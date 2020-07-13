### INCLUDE GUARD BEGIN ###
if(__offline_EDM_macro)
    return()
endif()
set(__offline_EDM_macro true)
### INCLUDE GUARD END ###

include(CMakeParseArguments)
include(XOD)
include(RootDict)
#############################################################################
# Build Event Data Model 
# + HDRDIR: Header
# + FILES
#       Generate Dict
# + SRCS
#       .cc files
# + HDRS
#       .h files only
#############################################################################
function(EDM _package)

    # = Prelude =
    # == cache package name ==
    set_property(GLOBAL
        APPEND
        PROPERTY OFFLINE_PACKAGES "${_package}"
    )
    set_property(GLOBAL
        PROPERTY "${_package}_root" "${CMAKE_CURRENT_SOURCE_DIR}"
    )

CMAKE_PARSE_ARGUMENTS(ARG "BASE;NOXOD" "HDRDIR" "FILES;HDRS;SRCS;DEPENDS" "" ${ARGN})

set(_files "${ARG_FILES}")
set(_srcs "${ARG_SRCS}")
set(_hdr_dir "Event")

if (ARG_HDRDIR)
    set(_hdr_dir "${ARG_HDRDIR}")
endif(ARG_HDRDIR)

FILE(MAKE_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/Event 
                    ${CMAKE_CURRENT_BINARY_DIR}/src
                    ${CMAKE_CURRENT_BINARY_DIR}/xml
)

include_directories(${CMAKE_CURRENT_SOURCE_DIR})
include_directories(${CMAKE_CURRENT_BINARY_DIR})

set(list_xod_src_${_package})

if (ARG_NOXOD)
    message("EDM ${_package} will not use XOD")
    # if don't use XOD, append _files to SRCS

    foreach (_f ${_files})
        set(_index -1)
        if (_srcs)
            list (FIND _srcs "${_f}" _index)
        endif(_srcs)
        if (${_index} GREATER -1)

        else()
            list (APPEND _srcs "${_f}")
        endif()

    endforeach()
else()
    # generate source code
    xod_gen_lists(${_package}
        FILES
        ${_files}
        SRCS
        ${_srcs}
    )

    get_property(list_xod_src_${_package} DIRECTORY PROPERTY xod_src_v2)
endif()

# == generate root dict ==
add_custom_target(target_xod_${_package}
    DEPENDS ${list_xod_src_${_package}}
)

#message("${list_xod_src_${_package}}")
foreach (_f ${_files})
    set (_linkdef)
    set (_header)
    if (ARG_NOXOD)
        set(_linkdef "${CMAKE_CURRENT_SOURCE_DIR}/src/${_f}LinkDef.h")
        set(_header "${CMAKE_CURRENT_SOURCE_DIR}/${_hdr_dir}/${_f}.h")
    else()
        set(_linkdef "${CMAKE_CURRENT_BINARY_DIR}/src/${_f}LinkDef.h")
        set(_header "${CMAKE_CURRENT_BINARY_DIR}/${_hdr_dir}/${_f}.h")
    endif()
    ROOT_GENERATE_DICTIONARY(${CMAKE_CURRENT_BINARY_DIR}/src/${_f}Dict
        ${_header}
        LINKDEF ${_linkdef}
        DEPENDS target_xod_${_package}
    )
endforeach(_f)

set (src_${_package}_list)
foreach (_f ${_files})
    set(_index -1)
    if (_srcs)
        list (FIND _srcs "${_f}" _index)
    endif(_srcs)
    #message("index: " "${_index}")
    if (${_index} GREATER -1)
        list(APPEND src_${_package}_list "${CMAKE_CURRENT_SOURCE_DIR}/src/${_f}.cc")
    else()
        list(APPEND src_${_package}_list "${CMAKE_CURRENT_BINARY_DIR}/src/${_f}.cc")
    endif()
    list(APPEND src_${_package}_list "${CMAKE_CURRENT_BINARY_DIR}/src/${_f}Dict.cxx")
endforeach(_f)

#message("${_package} SRC: " "${src_${_package}_list}")

add_library(${_package} SHARED 
    ${src_${_package}_list}
)
add_dependencies(${_package} target_xod_${_package})

set(${_package}_depends)
if (ARG_BASE)

else()
    foreach(_f EDMUtil BaseEvent )
        list(APPEND ${_package}_depends ${_f})
    endforeach()
endif()

target_link_libraries(${_package}
    ${${_package}_depends}
    ${ROOT_LIBRARIES}
    ${ARG_DEPENDS}
)
target_include_directories(${_package}
    PUBLIC
        $<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}>
    PUBLIC
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
)

# copy the Event/* into build tree
foreach (_f ${_files} ${ARG_HDRS})

set(_header)
if (ARG_NOXOD)
    set(_header "${CMAKE_CURRENT_SOURCE_DIR}/${_hdr_dir}/${_f}.h")
else()
    set(_header "${CMAKE_CURRENT_BINARY_DIR}/${_hdr_dir}/${_f}.h")
endif()

execute_process(
    COMMAND ${CMAKE_COMMAND} -E make_directory ${CMAKE_BINARY_DIR}/include/${_hdr_dir}
    COMMAND ${CMAKE_COMMAND} -E copy_if_different 
        ${_header}
        ${CMAKE_BINARY_DIR}/include/${_hdr_dir}/${_f}.h
)
endforeach(_f)


endfunction(EDM)
