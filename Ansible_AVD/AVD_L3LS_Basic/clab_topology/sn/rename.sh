#!/bin/bash

for file in ks-l3ls-*.txt; do
    newname="${file/l3ls/l3ls-basic}"
    mv "$file" "$newname"
    echo "Renamed $file to $newname"
done