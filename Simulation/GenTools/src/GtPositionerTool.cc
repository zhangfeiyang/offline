#include <boost/python.hpp>
#include <boost/regex.hpp>
#include <iostream>
#include <algorithm>

#include "SniperKernel/ToolFactory.h"
#include "SniperKernel/SniperLog.h"

#include "HepMC/GenEvent.h"
#include "HepMC/GenVertex.h"
#include "HepMC/GenParticle.h"

#include "GtPositionerTool.h"

// geant4 Related
#include "G4TransportationManager.hh"
#include "G4Navigator.hh"
#include "G4VPhysicalVolume.hh"
#include "G4LogicalVolume.hh"
#include "G4VSolid.hh"
#include "Randomize.hh"                                                         
#include "G4GeometryTolerance.hh"                                               
                                                                                
#include "G4VoxelLimits.hh"                                                     
#include "G4AffineTransform.hh"                                                 
#include "G4VisExtent.hh"  
#include "G4Material.hh"

DECLARE_TOOL(GtPositionerTool);

GtPositionerTool::GtPositionerTool(const std::string& name)
    : ToolBase(name)
{
    m_init_detector = true;
    declProp("GenInVolume", m_gen_volume); // Physical Volume's Name
    declProp("Material", m_material);

    declProp("PositionMode", m_position_mode="Random");
    declProp("Positions", m_particlePositions);
    declProp("RadiusCut", m_particleRadiusCuts); // limit the position

    declProp("ZCut", m_particleZCuts);
    declProp("XCut", m_particleXCuts);
    declProp("YCut", m_particleYCuts);

}

GtPositionerTool::~GtPositionerTool()
{

}

bool
GtPositionerTool::configure()
{
    if (m_position_mode == "Random" 
            and (m_material.size() == 0 or m_gen_volume.size() == 0)) {
        return false;
    }
    if (m_position_mode == "GenInGlobal") {
        // check the position 
        const std::vector<double>& pos = m_particlePositions;
        if (pos.size() != 3) {
            return false;
        }
        // the position is ok now
    }
    return true;
}

bool
GtPositionerTool::mutate(HepMC::GenEvent& event)
{
    // Get Fix/Random Position
    G4ThreeVector local_pos; 

    if (m_position_mode == "GenInGlobal") {
        const std::vector<double>& pos = m_particlePositions;
        local_pos = G4ThreeVector(pos[0], pos[1], pos[2]);
    } else { 
        if (m_init_detector) {
            if (init_detector()) {
                m_init_detector = false;
            } else {
                return false;
            }
            // after the initialize, print the current info
            LogDebug << "TransCache: " << std::endl;
            for (TransCache::iterator it = m_TC.begin();
                    it != m_TC.end(); ++it) {
                LogDebug << "+ " << it->first << std::endl;
                LogDebug << "++ " << (it->second).size() << std::endl;
            }
        }

        int total = m_TC[m_gen_volume].size();
        int index = total*G4UniformRand();

        G4AffineTransform g2l = m_TC[m_gen_volume][index];
        G4AffineTransform l2g = g2l.Inverse();
        while (true) {
            local_pos = get_pos();
            LogDebug << "-- Local Position: " << local_pos.x() 
                                       << ", " << local_pos.y()
                                       << ", " << local_pos.z()
                                       << std::endl;
            // transform the position
            l2g.ApplyPointTransform(local_pos);
            LogDebug << "-- Global Position: " << local_pos.x() 
                                       << ", " << local_pos.y()
                                       << ", " << local_pos.z()
                                       << std::endl;
            // the local_pos is global now
            
            // select the material 
            if (is_that_material(local_pos) and is_in_range(local_pos)) {
                break;
            }
        }
    }

    // set the position in GenEvent
    HepMC::GenEvent::vertex_iterator vtx, done = event.vertices_end();
    HepMC::FourVector pos(local_pos.x(), local_pos.y(), local_pos.z(), 0);
    for (vtx = event.vertices_begin(); vtx != done; ++vtx) {
        HepMC::FourVector position4d = pos;
        position4d.setT((*vtx)->position().t());
        (*vtx)->set_position(position4d);
    }
    return true;
}

bool
GtPositionerTool::init_detector()
{
    G4Navigator* gNavigator =
        G4TransportationManager::GetTransportationManager()
        ->GetNavigatorForTracking();

    G4VPhysicalVolume* pworld = gNavigator->GetWorldVolume();
    G4LogicalVolume* lworld = pworld->GetLogicalVolume();

    // save PV name of world
    m_pv_name_cache.insert(pworld->GetName());

    traverse(lworld, 0);

    // go through all the volumes
    // Note: because some detector elements encoded copyno in names,
    //       so it's better to filter such name.
    //       The filter pattern:
    //         .+?\d+$
    //       \D: non-number, \d: number
    // const char* pattern = "(\\D+)\\d+";
    const char* pattern = "^(.+?)\\d+$";
    boost::regex pv_regex(pattern);
    boost::smatch what;

    std::map<std::string, int> counter_pv;

    LogInfo << "All available physical volumes: " << std::endl;
    for (LVMatCache::iterator it = m_pv_name_cache.begin();
	 it != m_pv_name_cache.end(); ++it) {

        if (regex_match(*it, what, pv_regex)) {
            if (what.size()) ++counter_pv[ what[1] ];
        } else {
	    LogInfo << " --> " << *it << std::endl;
        }
    }
    for (std::map<std::string, int>::iterator it = counter_pv.begin();
         it != counter_pv.end(); ++it) {
        LogInfo << " --> prefix: " << it->first << " repeated: " << it->second << std::endl;
    }

    // Check the material name in logical volume
    G4LogicalVolume* selected_volume = m_lv_cache[m_gen_volume];
    if (!selected_volume) {
        LogError << "Can't find phys volume called " << m_gen_volume << std::endl;
        return false;
    }

    traverse_mat(selected_volume);

    // dump all the materials in selected_volume
    LogInfo << " All the materials in " << m_gen_volume << std::endl;
    for (LVMatCache::iterator it = m_lv_mat_cache.begin();
            it != m_lv_mat_cache.end(); ++it) {
        LogInfo << " --> " << *it << std::endl;
    }

    if (!m_lv_mat_cache.count(m_material)) {
        LogError << "Can't find material " << m_material
                 << " in volume " << m_gen_volume
                 << std::endl;
        return false;
    }

    return true;
}

bool
GtPositionerTool::traverse(G4LogicalVolume* lv, int depth, bool mute) 
{
    G4AffineTransform at_start;
    if (depth == 0) {
        m_path_cache.push_back(at_start);
    } else {
        at_start = m_path_cache.back();
    }

    // current volume
    std::string tmp_indent = "+";
    for (int i = 0; i < depth; ++i) {
        tmp_indent += "+";
    }
    if (not mute) {
    LogDebug << tmp_indent << " " << lv->GetName() << std::endl;
    }
    // daughter
    int daughter_count = lv->GetNoDaughters();

    G4String last_pv_name;
    int counter_pvs = 0;
    std::string tmp_indent_2 = "-";
    for (int j = 0; j < depth; ++j) { tmp_indent_2 += "-"; }

    for (int i = 0; i < daughter_count; ++i) {
        const G4VPhysicalVolume* const physvol = lv->GetDaughter(i);
        G4LogicalVolume* daughter = physvol->GetLogicalVolume();

	if (!m_pv_name_cache.count(physvol->GetName())) {
	    m_pv_name_cache.insert(physvol->GetName());
	}

        G4AffineTransform current = at_start;
        current.InverseProduct(
                    G4AffineTransform(at_start),
                    G4AffineTransform(
                        physvol->GetRotation(), physvol->GetTranslation()
                    )
                );

        // push
        m_path_cache.push_back(current);


        if (last_pv_name != physvol->GetName()) {
            if (counter_pvs > 1) {
                if (not mute) {
                LogDebug << tmp_indent_2 << ": total: " << counter_pvs << std::endl;
                }
            }
            if (not mute) {
            LogDebug << tmp_indent_2 << " [" 
                                     << physvol->GetName() 
                                     << "]" << std::endl;
            }
            last_pv_name = physvol->GetName();
            counter_pvs = 0;
        }

        ++counter_pvs;

        if (m_gen_volume.size() and physvol->GetName() == G4String(m_gen_volume)) {
            // find one of the volume
            // Save the Affine Transform
            m_TC[m_gen_volume].push_back(current);

            if (m_lv_cache.count(m_gen_volume) > 0) {
                assert ( daughter == m_lv_cache[m_gen_volume] );
            } else {
                m_lv_cache[m_gen_volume] = daughter;
            }
        }
        bool tmp_mute = mute;
        if (counter_pvs > 1) {
            tmp_mute = true;
        }
        traverse(daughter, depth+1, tmp_mute);

        // pop
        m_path_cache.pop_back();
    }
    // end of loop, check the final count
    if (daughter_count > 1 and counter_pvs > 1) {
        if (not mute) {
        LogDebug << tmp_indent_2 << ": total: " << counter_pvs << std::endl;
        }
    }
    return true;
}

bool
GtPositionerTool::traverse_mat(G4LogicalVolume* lv) {

    G4String mat_name = lv->GetMaterial()->GetName();
    if (!m_lv_mat_cache.count(mat_name)) {
        m_lv_mat_cache.insert(mat_name);
    }

    int daughter_count = lv->GetNoDaughters();
    for (int i = 0; i < daughter_count; ++i) {
        const G4VPhysicalVolume* const physvol = lv->GetDaughter(i);
        G4LogicalVolume* daughter = physvol->GetLogicalVolume();

        traverse_mat(daughter);

    }

    return true;
}

G4ThreeVector
GtPositionerTool::get_pos() {
    // return local position
    // Get the solid of that LV
    G4LogicalVolume* cur_lv = m_lv_cache[m_gen_volume];
    assert(cur_lv);
    G4VSolid* cur_solid = cur_lv->GetSolid();

    // Copy from G4VSolid.cc
    G4double px,py,pz,minX,maxX,minY,maxY,minZ,maxZ;
    G4VoxelLimits limit;                // Unlimited 
    EInside in;
    G4AffineTransform origin; 

    cur_solid->CalculateExtent(kXAxis,limit,origin,minX,maxX);                         
    cur_solid->CalculateExtent(kYAxis,limit,origin,minY,maxY);                         
    cur_solid->CalculateExtent(kZAxis,limit,origin,minZ,maxZ); 

    G4ThreeVector pos;
    G4double dX=maxX-minX;                                                        
    G4double dY=maxY-minY;                                                        
    G4double dZ=maxZ-minZ; 
    while (true) {
        px = minX+dX*G4UniformRand();
        py = minY+dY*G4UniformRand();
        pz = minZ+dZ*G4UniformRand();

        pos  = G4ThreeVector(px,py,pz);
        in = cur_solid->Inside(pos);

        if (in != kOutside) {
            return pos;
        }
    }

}

bool
GtPositionerTool::is_that_material(const G4ThreeVector& global_pos)
{
    G4Navigator* gNavigator =
        G4TransportationManager::GetTransportationManager()
        ->GetNavigatorForTracking();
    G4VPhysicalVolume* pv;
    pv = gNavigator ->
            LocateGlobalPointAndSetup(global_pos, 0, true);
    G4LogicalVolume* pv_log = pv->GetLogicalVolume();
    G4Material* pv_mat = pv_log->GetMaterial();
    return pv_mat->GetName() == G4String(m_material);

}

bool
GtPositionerTool::is_in_range(const G4ThreeVector& global_pos)
{
    bool isOK = false;

    int size = m_particleRadiusCuts.size();
    double r = global_pos.getR();
    if (size == 0) {
        // no cut
        isOK = true;
    } else if (size == 1) {
        // r < max
        if (r<m_particleRadiusCuts[0]) {
            isOK = true;
        } else {
            isOK = false;
        }
    } else if (size == 2) {
        double r_min = std::min(m_particleRadiusCuts[0], m_particleRadiusCuts[1]);
        double r_max = std::max(m_particleRadiusCuts[0], m_particleRadiusCuts[1]);

        if (r_min<=r and r<r_max) {
            isOK = true;
        } else {
            isOK = false;
        }
    }

    // now, check z cut
    size = m_particleZCuts.size();
    if (size == 2) {
        double z_min = std::min(m_particleZCuts[0], m_particleZCuts[1]);
        double z_max = std::max(m_particleZCuts[0], m_particleZCuts[1]);
        if (z_min <= global_pos.z() and global_pos.z() <= z_max) {
            isOK = isOK and true;
        } else {
            isOK = isOK and false;
        }
    }

    // now, check x cut
    size = m_particleXCuts.size();
    if (size == 2) {
        double x_min = std::min(m_particleXCuts[0], m_particleXCuts[1]);
        double x_max = std::max(m_particleXCuts[0], m_particleXCuts[1]);
        if (x_min <= global_pos.x() and global_pos.x() <= x_max) {
            isOK = isOK and true;
        } else {
            isOK = isOK and false;
        }
    }
    // now, check y cut
    size = m_particleYCuts.size();
    if (size == 2) {
        double y_min = std::min(m_particleYCuts[0], m_particleYCuts[1]);
        double y_max = std::max(m_particleYCuts[0], m_particleYCuts[1]);
        if (y_min <= global_pos.y() and global_pos.y() <= y_max) {
            isOK = isOK and true;
        } else {
            isOK = isOK and false;
        }
    }


    return isOK;
}
