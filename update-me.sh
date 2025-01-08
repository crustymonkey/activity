#!/bin/bash

function update() {
    local file="$1"
    local bump_by="$2"

    local num="$(cat $file)"
    num=$(( $num + 1 ))

    echo -n "$num" > $file
    echo -n "$num"
}

function main() {
    local bump_by="$1"
    local data="$(dirname $0)/data.upd"

    if [[ $bump_by == '-h' || $bump_by == '--help' ]] ; then
        echo "$0 [BUMP_BY]"
        echo
        echo "  Bump the data file by BUMP_BY"
        return 0
    fi

    [[ -z $bump_by ]] && bump_by=1

    local cur_dir="$(pwd)"
    cd "$(dirname $0)"

    git pull

    local num="$(update "$data" "$bump_by")"
    git commit -a -m "Commit for $num"
    git push

    cd "$cur_dir"
}

main "$@"
