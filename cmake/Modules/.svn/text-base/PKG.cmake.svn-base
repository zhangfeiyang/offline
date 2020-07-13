### INCLUDE GUARD BEGIN ###
if(__offline_PKG_macro)
    return()
endif()
set(__offline_PKG_macro true)
### INCLUDE GUARD END ###

include(CMakeParseArguments)

#############################################################################
# PKG
# = PKGONLY =
# * Only placeholder, maybe with share
#
# = Build Algorithm =
# * By default, we assume the algorithm directory structure is:
#   + src
#   + python (optional)
#   + share (optional)
#   + test (optional)
#
# = Build Service =
# * By default, we assume the service directory structure is:
#   + PkgName (Header)
#   + src
#   + include (optional)
#   + python (optional)
#   + share (optional)
#   + test (optional)
#
# = Build Application =
# * Two cases:
#   + app only. Don't need libraries.
#   + app with lib. 
# 
#   APP app_name FILES app_src
#   APPONLY app_name
#############################################################################

function(PKG _package)

    # = Prelude =
    # == cache package name ==
    set_property(GLOBAL
        APPEND
        PROPERTY OFFLINE_PACKAGES "${_package}"
    )
    set_property(GLOBAL
        PROPERTY "${_package}_root" "${CMAKE_CURRENT_SOURCE_DIR}"
    )

    # == depends ==
    PRJ_DEPENDS_PKG(${_package})

    # == parse arguments ==
    CMAKE_PARSE_ARGUMENTS(ARG "PKGONLY;PYONLY" "APP;APPONLY" "FILES;DEPENDS;EXCLUDES;DICTS" "" ${ARGN})

    include_directories (${CMAKE_CURRENT_SOURCE_DIR})
    include_directories (src)
    include_directories (include)

    # = Collect source code =
    AUX_SOURCE_DIRECTORY(src _src_${_package}_lists)
    # remove files in exclude list
    foreach (_f ${ARG_EXCLUDES})
        list (REMOVE_ITEM _src_${_package}_lists "${_f}")
    endforeach()

    set(src_${_package}_lists)
    
    # remove files in _src_${_package}_lists
    foreach (_f ${_src_${_package}_lists})
        set(_index -1)
        if (ARG_FILES)
            list(FIND ARG_FILES "${_f}" _index)
        endif(ARG_FILES)

        if (${_index} GREATER -1)

        else()
            list(APPEND src_${_package}_lists "${_f}")
        endif()
    endforeach(_f)

    # Dict
    # Here, we assume header is given by user
    if (ARG_DICTS)
    FILE(MAKE_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/Event 
                        ${CMAKE_CURRENT_BINARY_DIR}/src
                        ${CMAKE_CURRENT_BINARY_DIR}/xml
    )

    include_directories(${CMAKE_CURRENT_SOURCE_DIR}/Event)
    include_directories(${CMAKE_CURRENT_SOURCE_DIR}/src)
    include_directories(${CMAKE_CURRENT_BINARY_DIR}/Event)
    include_directories(${CMAKE_CURRENT_BINARY_DIR}/src)

    # Note: it's possible to use header under ${_package} directory,
    #       but it's better to avoid.
    # if(IS_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/${_package})
    #     include_directories(${CMAKE_CURRENT_SOURCE_DIR}/${_package})
    # endif()

    foreach (_f ${ARG_DICTS})
        set (_header)
        set (_linkdef)
        if(EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/${_package}/${_f}.h")
            set (_header "${CMAKE_CURRENT_SOURCE_DIR}/${_package}/${_f}.h")
        elseif(EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/Event/${_f}.h")
            set (_header "${CMAKE_CURRENT_SOURCE_DIR}/Event/${_f}.h")
        elseif(EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/include/${_f}.h")
            set (_header "${CMAKE_CURRENT_SOURCE_DIR}/include/${_f}.h")
        elseif(EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/src/${_f}.h")
            set (_header "${CMAKE_CURRENT_SOURCE_DIR}/src/${_f}.h")
        else()

        endif()

        set (_linkdef "${CMAKE_CURRENT_SOURCE_DIR}/src/${_f}LinkDef.h")
        ROOT_GENERATE_DICTIONARY(${CMAKE_CURRENT_BINARY_DIR}/src/${_f}Dict
            ${_header}
            LINKDEF ${_linkdef}
        )

        list(APPEND src_${_package}_lists "${CMAKE_CURRENT_BINARY_DIR}/src/${_f}Dict.cxx")
    endforeach()
    endif(ARG_DICTS)

    if (ARG_APPONLY)
        # = Build Application only =
        add_executable(${ARG_APPONLY}
            ${src_${_package}_lists}
            ${ARG_FILES}
        )

        target_link_libraries(${ARG_APPONLY}
            ${ARG_DEPENDS}
            ${ROOT_LIBRARIES}
            ${CLHEP_LIBRARIES}
        )

    elseif(ARG_PKGONLY)
        # = copy share only =
        add_custom_target(${_package} ALL
            COMMAND ${CMAKE_COMMAND} -E make_directory
                ${CMAKE_BINARY_DIR}/share/${_package}
            COMMAND ${CMAKE_COMMAND} -E copy_directory
                ${CMAKE_CURRENT_SOURCE_DIR}/share
                ${CMAKE_BINARY_DIR}/share/${_package}
            COMMENT "Install share of ${_package}"
        )

    elseif(ARG_PYONLY)
        # = only install python library =
        add_custom_target(${_package} ALL
            COMMAND ${CMAKE_COMMAND} -E make_directory
                ${CMAKE_BINARY_DIR}/python/${_package}
            COMMAND ${CMAKE_COMMAND} -E copy_directory
                ${CMAKE_CURRENT_SOURCE_DIR}/python/${_package}
                ${CMAKE_BINARY_DIR}/python/${_package}
            COMMENT "Install python module of ${_package}"
        )

    else()
        
        if (ARG_APP)
            add_executable(${ARG_APP}
                ${ARG_FILES}
            )

            target_link_libraries(${ARG_APP}
                ${_package}
            )
        else()
            set(src_${_package}_lists ${src_${_package}_lists} ${ARG_FILES})
        endif()

        # = Build Library =
        add_library(${_package} SHARED
            ${src_${_package}_lists}
        )

        target_link_libraries(${_package}
            ${ARG_DEPENDS}

            SniperKernel
            ${ROOT_LIBRARIES}
        )


        # = Decalre include directory =
        target_include_directories(${_package}
            PUBLIC
                $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
            PUBLIC
                $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
            PRIVATE
                $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/src>
        )

        # = copy public header =
        if(IS_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/${_package})
            execute_process(
                COMMAND ${CMAKE_COMMAND} -E make_directory
                    ${CMAKE_BINARY_DIR}/include/${_package}
                COMMAND ${CMAKE_COMMAND} -E copy_directory
                    ${CMAKE_CURRENT_SOURCE_DIR}/${_package}
                    ${CMAKE_BINARY_DIR}/include/${_package}
            )
        endif()

        # = copy python =
        if(IS_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/python/${_package})
            execute_process(
                COMMAND ${CMAKE_COMMAND} -E make_directory
                    ${CMAKE_BINARY_DIR}/python/${_package}
                COMMAND ${CMAKE_COMMAND} -E copy_directory
                    ${CMAKE_CURRENT_SOURCE_DIR}/python/${_package}
                    ${CMAKE_BINARY_DIR}/python/${_package}
            )
        endif()

    endif()

endfunction(PKG)
