#!/bin/bash

#########################################
# Description
#   * load gen-positron-center.sh, 
#   * override the 'detsim-mode' command
#########################################

source $JUNOTESTROOT/production/libs/chain-template.sh

#########################################
# parse the tag 
#   TAG="$NAME"
#########################################
function l-parse-tag() {
    local tag=$1; shift;
    export L_PARTICLE_NAME=$tag
}
#########################################
# override the detsim command
#########################################
# allow U-238, Th-232, K-40, Co-60
function l-particle-name() {
    echo ${L_PARTICLE_NAME:-U-238}
}
function detsim-mode() {
cat << EOF
    gendecay --nuclear $(l-particle-name)
        --volume pTarget
        --material LS
EOF
}

#########################################
# main function
# this technique allows developers 
# reuse it.
#########################################
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    parse_cmds "$@"
fi
