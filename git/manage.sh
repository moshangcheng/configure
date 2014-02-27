#!/bin/bash

# arg 0 - directory contains projects
function list_projects
{
    for p in $(find "$1" -maxdepth 2 -mindepth 2 -type d | sort); do
        # git bash on Windows doesn't support pushd -q
        pushd "$p" > /dev/null
        git config --get remote.origin.url
        popd > /dev/null
    done
}

# arg 0 - file records all projects
function create_projects
{
    for p in $(cat "$1"); do
        dir=$(echo "$p" | awk -F '/' '{print $4}')
        [[ -d "$dir" ]] || mkdir "$dir"
        cd "$dir"
        git clone "$p" &
        cd ..
    done
    wait
}

function git_operation
{
    for p in $(find "$dir" -maxdepth 2 -mindepth 2 -type d | sort); do
        # git bash on Windows doesn't support pushd -q
        pushd "$p" > /dev/null

        git "$@" &

        popd > /dev/null
    done
    wait
}

if [[ "$1" = "" || "$1" = "-h" || "$1" = "--help" ]]; then
    echo "Usage: manage.sh [directory] [action] [args...]"
    echo ""
    echo "where actions include:"
    echo "  list        list all projects in a directory"
    echo "  create      create projects listed in a file"
    echo "  comapre     compare projects in a directory with projects listed in  file"
    echo "  git         do git operations for all projects"
    echo ""
    echo "examples:"
    echo "  manage.sh ~/dev/src/github.com list "
    echo "  manage.sh ~/dev/src/github.com create projects.txt"
    echo "  manage.sh ~/dev/src/github.com compare projects.txt"
    echo "  manage.sh ~/dev/src/github.com git pull"
    exit 1
fi

if [[ -d "$1" ]]; then
    dir="$1"
    shift
else
    dir=$(pwd)
fi

if [[ "$1" = "list" ]]; then
    list_projects "$dir"
    exit 0
fi

if [[ "$1" = "compare" ]]; then
    if [[ ! -e "$2" ]]; then
        echo file "$3" does not exist
    else
        echo compare source directory "$2" with projects in "$3"
    fi
fi

if [[ "$1" = "git" ]]; then
    shift
    git_operation "$@"
    exit 0
fi
