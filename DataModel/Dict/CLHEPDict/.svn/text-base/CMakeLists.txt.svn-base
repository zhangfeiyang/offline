include (RootDict)

FILE(MAKE_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/src)

include_directories(${CMAKE_CURRENT_SOURCE_DIR}/src)

# == generate root dict ==
ROOT_GENERATE_DICTIONARY(${CMAKE_CURRENT_BINARY_DIR}/src/CLHEPIncDict
    ${CMAKE_CURRENT_SOURCE_DIR}/src/CLHEPInc.h
    LINKDEF ${CMAKE_CURRENT_SOURCE_DIR}/src/CLHEPIncLinkDef.h
    OPTIONS -p
)

add_library(CLHEPDict SHARED 
    ${CMAKE_CURRENT_BINARY_DIR}/src/CLHEPIncDict.cxx
)

target_link_libraries(CLHEPDict
    ${ROOT_LIBRARIES}
    ${CLHEP_LIBRARIES}
)
