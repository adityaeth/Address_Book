#!/bin/bash
# Address Book

# Author: Aditya Prakash 
# https://adityaeth.github.io/

# Creating file for first run

if [ ! -f $BOOK]; then
    echo "Creating $BOOK..."
    touch $BOOK
fi

# Checking read permissions

if [ ! -r $BOOK ]; then
    echo "Error: $BOOK not readable"
    exit 1
fi

# Checking write permissions

if [ ! -w $BOOK]; then
    echo "Error: $BOOK not writable"
    exit 2
fi

