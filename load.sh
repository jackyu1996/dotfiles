#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

echo "Now linking symbolic configs"
exclude=".git|$(basename "$0")"
all=$(tree -aif --matchdirs -I "$exclude" --noreport)

for conf in $all ; do
    if [[ -d $conf ]]; then
        mkdir -p "../$conf"
    elif [[ -f $conf ]]; then
        echo "Linking $conf"
        ln -sf "$(realpath "$conf")" "../$(dirname "$conf")"
    fi
done

echo "Done"
