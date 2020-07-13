
#include "HexagonPosBall.hh"
#include "G4ThreeVector.hh"
#include "G4RotationMatrix.hh"

#include <istream>
#include <fstream>
#include <sstream>

namespace JUNO {

namespace Ball {

HexagonPosBall::HexagonPosBall(G4String filename, G4double r)
    : m_filename(filename), m_ball_r(r) {
    initialize();
    m_position_iter = m_position.begin();
}

HexagonPosBall::~HexagonPosBall() {

}

G4bool 
HexagonPosBall::hasNext() {
    return m_position_iter != m_position.end();
}

G4Transform3D
HexagonPosBall::next() {
    return *(m_position_iter++);
}

void
HexagonPosBall::initialize() {
    std::ifstream pmtsrc(m_filename.c_str());
    std::string tmp_line;
    G4int copyno; 
    G4double theta; // degree
    G4double phi; // degree
    G4double psi; // degree
    while (pmtsrc.good()) {
        std::getline(pmtsrc, tmp_line);
        if (pmtsrc.fail()) {
            break;
        }

        std::stringstream ss;
        ss << tmp_line;

        ss >> copyno >> theta >> phi;

        if (ss.fail()) {
            continue;
        }

        // psi: the rotation by z axis
        ss >> psi;
        if (ss.fail()) {
            psi = 0.0;
        }

        theta = theta * deg;
        phi = phi * deg;
        psi = psi * deg;

        // construct G4Transform3D
        G4double x = (m_ball_r) * sin(theta) * cos(phi);
        G4double y = (m_ball_r) * sin(theta) * sin(phi);
        G4double z = (m_ball_r) * cos(theta);
        G4ThreeVector pos(x, y, z);
        G4RotationMatrix rot;
        rot.rotateZ(psi); 
        rot.rotateY(pi + theta);
        rot.rotateZ(phi);
        G4Transform3D trans(rot, pos);

        // Append trans
        m_position.push_back(trans);

    }

    pmtsrc.close();
}

}

}
