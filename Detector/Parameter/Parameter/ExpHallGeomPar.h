#ifndef JUNO_EXPHALL_GEOM_PAR_H
#define JUNO_EXPHALL_GEOM_PAR_H

#include <iostream>

class ExpHallGeomPar
{
    public:

        ExpHallGeomPar() { std::cout << "ExpHallGeomPar constructor" << std::endl; }
        ~ExpHallGeomPar() { std::cout << "ExpHallGeomPar destructor" << std::endl; }

	double GetExpHallXLength() { return m_expHallXlen; }
        double GetExpHallYLength() { return m_expHallYlen; }
        double GetExpHallZLength() { return m_expHallZlen; }

	void InitExpHallVariables();

    private:

	double m_expHallXlen;
	double m_expHallYlen;
	double m_expHallZlen;

	void SetExpHallXLength(double expHallXlen) { m_expHallXlen = expHallXlen; }
        void SetExpHallYLength(double expHallYlen) { m_expHallYlen = expHallYlen; }
        void SetExpHallZLength(double expHallZlen) { m_expHallZlen = expHallZlen; }

};

#endif
