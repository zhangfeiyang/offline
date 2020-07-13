### INCLUDE GUARD BEGIN ###
if(__offline_PRJ_macro)
    return()
endif()
set(__offline_PRJ_macro true)
### INCLUDE GUARD END ###

include(CMakeParseArguments)


#
# Declare a sub project name
#
function (PRJ _prj)
    set(_parent_prj)
    set(_current_prj)

    message("Before ${PROJECT_NAME}")
    set(_parent_prj "${PROJECT_NAME}")

    # #####################
    # create a project name
    # #####################
    project(${_prj})

    message("After ${PROJECT_NAME}")
    set(_current_prj "${PROJECT_NAME}")


    # #####################
    # parse arguments
    # #####################
    CMAKE_PARSE_ARGUMENTS(ARG "" "" "DEPENDS" "" ${ARGN})

    # #####################
    # XXX_project_depends
    # #####################
    set (_prj_depends_targets)
    if (ARG_DEPENDS)
        foreach(_p ${ARG_DEPENDS})
            set_property(GLOBAL
                APPEND
                PROPERTY "${_current_prj}_project_depends" "${_p}"
            )
            list(APPEND _prj_depends_targets "${_p}_project_target")
        endforeach()
    endif()

    add_custom_target("${_current_prj}_project_target"
        ALL
        DEPENDS
        ${_prj_depends_targets}
    )

endfunction(PRJ)

#
# Helpers
#

##
## Get Current Project Name
##
function (PRJ_CURRENT _prj)
    set (${prj} "${PROJECT_NAME}" PARENT_SCOPE)
endfunction(PRJ_CURRENT)

##
## Mark PRJ depends on packages in PRJ
## while packages depends on (PRJ_project_depends)
function (PRJ_DEPENDS_PKG _pkg)
    # if (TARGET "${PROJECT_NAME}_project_target")
    #     add_dependencies("${PROJECT_NAME}_project_target" ${_pkg})
    # endif()

    # set (_current_prj "${PROJECT_NAME}")
    # set (_p_depends)
    # get_property(_p_depends
    #     GLOBAL
    #     PROPERTY "${_current_prj}_project_depends"
    # )

    # if (_p_depends)
    #     foreach (_p "${_p_depends}")
    #         if (TARGET "${_p}_project_target")
    #             add_dependencies(${_pkg} "${_p}_project_target")
    #         endif()
    #     endforeach()
    # endif()
endfunction(PRJ_DEPENDS_PKG)
