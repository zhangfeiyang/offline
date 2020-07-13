#include "boost/python.hpp"
#include "boost/noncopyable.hpp"
#include "boost/make_shared.hpp"
#include "boost/python/suite/indexing/indexing_suite.hpp" 
#include "boost/python/suite/indexing/vector_indexing_suite.hpp" 
#include <vector>

namespace bp = boost::python;
// using namespace boost::python;

std::vector<double> makeTV(double x, double y, double z) {
    std::vector<double> v;
    v.push_back(x);
    v.push_back(y);
    v.push_back(z);
    return v;
}

#include "SniperKernel/AlgBase.h"
#include "GenTools.h"
BOOST_PYTHON_MODULE(libGenTools) 
{
    bp::class_< std::vector<double>  >("ThreeVector")
                    .def(bp::vector_indexing_suite< std::vector<double>  >())
        ;
    bp::def("makeTV", makeTV)
        ;
    bp::class_<GenTools, bp::bases<AlgBase>, boost::noncopyable >
        ("GenTools", bp::init<std::string>())
    ;

}
