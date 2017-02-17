#!/usr/bin/bash

PERMANENTLY=false
VERBOSE=false
ARGUMENT=false
ARGUMENTS=""


# checks flags given by the user
# sets PERMANENTLY and VERBOSE if nessessary
function check_flags() {
    echo $1

    case "$1" in
        -f|--force)
            PERMANENTLY=true
            ARGUMENT=true
            echo in_f
            ;;
        -v|--verbose)
            VERBOSE=true
            ARGUMENT=true
            echo in_v
            ;;
        -fv)
            VERBOSE=true
            PERMANENTLY=true
            ARGUMENT=true
            echo in_fv
            ;;
        -vf)
            VERBOSE=true
            PERMANENTLY=true
            ARGUMENT=true
            echo in_vf
            ;;
    esac
}

# gets rm arguments given by the user
function get_arguments() {
    # echo $ARGUMENT

    if  [ $ARGUMENT = "true" ]; then
        ARGUMENTS=${@:2}
    else
        ARGUMENTS=$@
    fi

    echo $ARGUMENTS
}

# creates trash directory if it does not exist
function check_trash() {
    if [ ! -d ~/.trash/ ]; then
        mkdir ~/.trash/
    fi
}

# delete or move the arguments
function delete() {
    check_trash

    if [ $PERMANENTLY = "true" ]; then
        if [ $VERBOSE = "true" ]; then
            rm -rfv $ARGUMENTS
        else
            rm -rf $ARGUMENTS
        fi
    else
        if [ $VERBOSE = "true" ]; then
            mv -v $ARGUMENTS ~/.trash/
        else
            mv $ARGUMENTS ~/.trash/
        fi
    fi
}

check_flags $@
get_arguments $@
delete
