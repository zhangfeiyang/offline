#ifndef GtGunGenTool_h
#define GtGunGenTool_h

#include "SniperKernel/ToolBase.h"
#include "GenTools/IGenTool.h"

#include "HepMC/SimpleVector.h"
#include "HepMC/GenParticle.h"

#include <vector>

class GtGunGenTool: public ToolBase,
                    public IGenTool
{
    public:
        GtGunGenTool(const std::string& name);
        ~GtGunGenTool();
        // The current toolbase don't have configure.
        bool configure();
        bool mutate(HepMC::GenEvent& event);

    private:
        HepMC::GenParticle* appendParticle(int index);
        HepMC::ThreeVector getMomentum(double p);
        int getPdgid(const std::string& particle_name);
        double getMass(const std::string& particle_name);

    private:

        std::vector<std::string> m_particleNames;
        std::vector<double> m_particleMomentums;
        /*
         * Momentum Interpretation
         *  * Momentum
         *  * TotalEnergy
         *  * KineticEnergy
         */
        std::string m_momOrKEOrTE;
        /*
         * Momentum Mode
         *  * Fix
         *  * Uniform (mean, half width)
         *  * Range [min, max]
         *  * Gaus (mean, sigma)
         */
        std::string m_particleMomentumMode;
        std::vector<double> m_particleMomentumParams;

        /*
         * Direction Mode:
         *  * Random
         *  * Fix
         *    If Fix mode is choosen, the user should set the directions.
         */
        std::string m_direction_mode;
        std::vector< std::vector<double> > m_particleDirections;

        /*  
         * Position Mode:
         *  * Omit: Set the positions in other tools
         *  * FixOne: Only one vertex 
         *  * FixMany: every particle will have its own vertex
         *
         */
        std::string m_position_mode;
        std::vector< std::vector<double> > m_particlePositions;
};
#endif
