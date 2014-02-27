#!/bin/bash

for project_url in $(cat ../project_list.txt); do
    dir=$(echo "$project_url" | awk -F '/' '{print $4}')
    [[ -d "$dir" ]] || mkdir "$dir"
    cd "$dir"
    git clone "$project_url" &
    cd ..
done
