#!/bin/bash

create_folder() {
    mkdir "$1"
    if [ $? -nei 0 ]; then
        echo "Error: Failed to create folder $1"
        exit 1

    fi

    echo "dfghcghjcvbjk"
}

create_folder "/restricted_folder"

