
macro(xod_copy_xdd)
    configure_file(
        ${CMAKE_SOURCE_DIR}/XmlObjDesc/xml_files/xdd.dtd
        ${CMAKE_CURRENT_BINARY_DIR}/xml/xdd.dtd
        COPYONLY
    )
endmacro(xod_copy_xdd)

macro(xod_copy_xml _file_xml)
    configure_file(
        ${CMAKE_CURRENT_SOURCE_DIR}/xml/${_file_xml}
        ${CMAKE_CURRENT_BINARY_DIR}/xml/${_file_xml}
        COPYONLY
    )
endmacro(xod_copy_xml)

macro(xod_gen_header _file_xml _file_obj2doth _file_h _file_linkdef)
    ADD_CUSTOM_COMMAND(OUTPUT
        ${CMAKE_CURRENT_BINARY_DIR}/src/${_file_linkdef}
        ${CMAKE_CURRENT_BINARY_DIR}/Event/${_file_h}
        COMMAND python ${CMAKE_SOURCE_DIR}/XmlObjDesc/scripts/godII.py 
                    -n JM
                    -f -b ${CMAKE_CURRENT_BINARY_DIR}/src 
                    -g src -r ${CMAKE_SOURCE_DIR}/XmlObjDesc 
                        ${CMAKE_CURRENT_BINARY_DIR}/xml/${_file_xml}
        COMMAND touch ${CMAKE_CURRENT_BINARY_DIR}/Event/${_file_obj2doth}
        WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/Event
        DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/xml/xdd.dtd
                ${CMAKE_CURRENT_BINARY_DIR}/xml/${_file_xml}
    )
    set_property(DIRECTORY
        APPEND
        PROPERTY xod_header ${CMAKE_CURRENT_BINARY_DIR}/Event/${_file_h}
    )
endmacro(xod_gen_header)

macro(xod_gen_src _file_h _file_cc)
    get_property(list_xod_headers DIRECTORY PROPERTY xod_header)
    # message("${list_xod_headers}")
    ADD_CUSTOM_COMMAND(OUTPUT
        ${CMAKE_CURRENT_BINARY_DIR}/src/${_file_cc}
        COMMAND python ${CMAKE_SOURCE_DIR}/XmlObjDesc/scripts/genSrc.py 
                        ${CMAKE_CURRENT_BINARY_DIR}/Event/${_file_h}
        WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/src
        DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/Event/${_file_h}
                ${list_xod_headers}
    )
endmacro(xod_gen_src)

# == .xml -> .h, .cc, .obj2doth ==
macro(xod_gen_all _file)
    # == header ==
    xod_copy_xml(${_file}.xml)
    xod_gen_header(${_file}.xml ${_file}.obj2doth ${_file}.h ${_file}LinkDef.h)

    # == source ==
    xod_gen_src(${_file}.h ${_file}.cc)
endmacro(xod_gen_all)


# A different version to generate XOD.
function(xod_gen_lists_v2 _label)
    CMAKE_PARSE_ARGUMENTS(ARG "" "" "FILES;SRCS" "" ${ARGN})
    set(_files "${ARG_FILES}")

    ADD_CUSTOM_COMMAND(OUTPUT
        ${CMAKE_CURRENT_BINARY_DIR}/xml/xdd.dtd
        COMMAND ${CMAKE_COMMAND} -E copy_if_different
            ${CMAKE_SOURCE_DIR}/XmlObjDesc/xml_files/xdd.dtd
            ${CMAKE_CURRENT_BINARY_DIR}/xml/xdd.dtd
        DEPENDS
            ${CMAKE_SOURCE_DIR}/XmlObjDesc/xml_files/xdd.dtd
    )

    foreach (_file ${_files})

        ADD_CUSTOM_COMMAND(OUTPUT
            ${CMAKE_CURRENT_BINARY_DIR}/xml/${_file}.xml
            COMMAND ${CMAKE_COMMAND} -E copy_if_different
                        ${CMAKE_CURRENT_SOURCE_DIR}/xml/${_file}.xml
                        ${CMAKE_CURRENT_BINARY_DIR}/xml/${_file}.xml
            DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/xml/xdd.dtd
                    ${CMAKE_CURRENT_SOURCE_DIR}/xml/${_file}.xml
        )

        ADD_CUSTOM_COMMAND(OUTPUT
            ${CMAKE_CURRENT_BINARY_DIR}/Event/${_file}.h
            COMMAND python ${CMAKE_SOURCE_DIR}/XmlObjDesc/scripts/godII.py 
                        -n JM
                        -f -b ${CMAKE_CURRENT_BINARY_DIR}/src 
                        -g src -r ${CMAKE_SOURCE_DIR}/XmlObjDesc 
                            ${CMAKE_CURRENT_BINARY_DIR}/xml/${_file}.xml
            COMMAND touch ${CMAKE_CURRENT_BINARY_DIR}/Event/${_file}.obj2doth
            WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/Event
            DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/xml/${_file}.xml
        )

        ADD_CUSTOM_COMMAND(OUTPUT
            ${CMAKE_CURRENT_BINARY_DIR}/src/${_file}LinkDef.h
            COMMAND touch ${CMAKE_CURRENT_BINARY_DIR}/src/${_file}LinkDef.h
            DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/Event/${_file}.h
        )
        set_property(DIRECTORY
            APPEND
            PROPERTY xod_header_v2 ${CMAKE_CURRENT_BINARY_DIR}/Event/${_file}.h
        )
        set_property(DIRECTORY
            APPEND
            PROPERTY xod_header_v2 ${CMAKE_CURRENT_BINARY_DIR}/src/${_file}LinkDef.h
        )
    endforeach(_file)

    get_property(list_xod_headers_v2_${_label} DIRECTORY PROPERTY xod_header_v2)

    foreach (_file ${_files})
        set(_index -1)
        if (ARG_SRCS)
            list (FIND ARG_SRCS "${_file}" _index)

        endif()

        if (${_index} GREATER -1)

        else()
            ADD_CUSTOM_COMMAND(OUTPUT
                ${CMAKE_CURRENT_BINARY_DIR}/src/${_file}.cc
                COMMAND python ${CMAKE_SOURCE_DIR}/XmlObjDesc/scripts/genSrc.py 
                                ${CMAKE_CURRENT_BINARY_DIR}/Event/${_file}.h
                WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/src
                DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/Event/${_file}.h
                        ${list_xod_headers_v2_${_label}}
            )
            set_property(DIRECTORY
                APPEND
                PROPERTY xod_src_v2 ${CMAKE_CURRENT_BINARY_DIR}/src/${_file}.cc
            )
        endif()
    endforeach(_file)

    get_property(list_xod_src_v2_${_label} DIRECTORY PROPERTY xod_src_v2)

    add_custom_target(xod_src_${_label}
        ALL
        DEPENDS ${list_xod_src_v2_${_label}}
    )

endfunction(xod_gen_lists_v2)




# use execute process, so during cmake stage, .h/.cc will be generated.
function(xod_gen_lists _label)
    CMAKE_PARSE_ARGUMENTS(ARG "" "" "FILES;SRCS" "" ${ARGN})
    set(_files "${ARG_FILES}")

    execute_process(
        COMMAND ${CMAKE_COMMAND} -E copy_if_different
            ${CMAKE_SOURCE_DIR}/XmlObjDesc/xml_files/xdd.dtd
            ${CMAKE_CURRENT_BINARY_DIR}/xml/xdd.dtd
        OUTPUT_QUIET
        ERROR_QUIET
    )

    foreach (_file ${_files})

        if (${CMAKE_CURRENT_SOURCE_DIR}/xml/${_file}.xml IS_NEWER_THAN ${CMAKE_CURRENT_BINARY_DIR}/Event/${_file}.obj2doth)
            message("${_label}: generating ${_file}.h/${_file}LinkDef.h from ${_file}.xml files")
            execute_process(
                COMMAND ${CMAKE_COMMAND} -E copy_if_different
                            ${CMAKE_CURRENT_SOURCE_DIR}/xml/${_file}.xml
                            ${CMAKE_CURRENT_BINARY_DIR}/xml/${_file}.xml
                OUTPUT_QUIET
                ERROR_QUIET
            )

            execute_process(
                COMMAND python ${CMAKE_SOURCE_DIR}/XmlObjDesc/scripts/godII.py 
                            -n JM
                            -f -b ${CMAKE_CURRENT_BINARY_DIR}/src 
                            -g src -r ${CMAKE_SOURCE_DIR}/XmlObjDesc 
                                ${CMAKE_CURRENT_BINARY_DIR}/xml/${_file}.xml
                COMMAND touch ${CMAKE_CURRENT_BINARY_DIR}/Event/${_file}.obj2doth
                WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/Event
                OUTPUT_QUIET
                ERROR_QUIET
            )
        endif()

        ADD_CUSTOM_COMMAND(OUTPUT
            ${CMAKE_CURRENT_BINARY_DIR}/Event/${_file}.h
            COMMAND python ${CMAKE_SOURCE_DIR}/XmlObjDesc/scripts/godII.py 
                            -n JM
                            -f -b ${CMAKE_CURRENT_BINARY_DIR}/src 
                            -g src -r ${CMAKE_SOURCE_DIR}/XmlObjDesc 
                                ${CMAKE_CURRENT_BINARY_DIR}/xml/${_file}.xml
            WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/Event
            DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/xml/${_file}.xml
        )
        ADD_CUSTOM_COMMAND(OUTPUT
            ${CMAKE_CURRENT_BINARY_DIR}/src/${_file}LinkDef.h
            COMMAND touch ${CMAKE_CURRENT_BINARY_DIR}/src/${_file}LinkDef.h
            DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/Event/${_file}.h
        )
        set_property(DIRECTORY
            APPEND
            PROPERTY xod_header_v2 ${CMAKE_CURRENT_BINARY_DIR}/Event/${_file}.h
        )
        set_property(DIRECTORY
            APPEND
            PROPERTY xod_header_v2 ${CMAKE_CURRENT_BINARY_DIR}/src/${_file}LinkDef.h
        )
    endforeach(_file)

    get_property(list_xod_headers_v2_${_label} DIRECTORY PROPERTY xod_header_v2)

    foreach (_file ${_files})
        set(_index -1)
        if (ARG_SRCS)
            list (FIND ARG_SRCS "${_file}" _index)

        endif()

        if (${_index} GREATER -1)

        else()
            if (${CMAKE_CURRENT_SOURCE_DIR}/xml/${_file}.xml 
                IS_NEWER_THAN 
                ${CMAKE_CURRENT_BINARY_DIR}/src/${_file}.cc)
            execute_process(
                COMMAND python ${CMAKE_SOURCE_DIR}/XmlObjDesc/scripts/genSrc.py 
                                ${CMAKE_CURRENT_BINARY_DIR}/Event/${_file}.h
                WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/src
                OUTPUT_QUIET
                ERROR_QUIET
            )
            endif()
        
            ADD_CUSTOM_COMMAND(OUTPUT
                ${CMAKE_CURRENT_BINARY_DIR}/src/${_file}.cc
                COMMAND python ${CMAKE_SOURCE_DIR}/XmlObjDesc/scripts/genSrc.py 
                                ${CMAKE_CURRENT_BINARY_DIR}/Event/${_file}.h
                WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/src
                DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/xml/${_file}.xml
            )

            set_property(DIRECTORY
                APPEND
                PROPERTY xod_src_v2 ${CMAKE_CURRENT_BINARY_DIR}/src/${_file}.cc
            )
        endif()
    endforeach(_file)

    get_property(list_xod_src_v2_${_label} DIRECTORY PROPERTY xod_src_v2)

    add_custom_target(xod_src_${_label}
        DEPENDS ${list_xod_src_v2_${_label}}
    )

endfunction(xod_gen_lists)

