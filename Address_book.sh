#!/bin/bash
# Address Book

# Author: Aditya Prakash 
# https://adityaeth.github.io/


menu()
{
    echo "\n\n\n\n"
    echo "----- Address Book -----"
    echo "1. List / Search"
    echo "2. Add"
    echo "3. Edit"
    echo "4. Remove"
    echo "q. quit"
    echo "-------------------------"
    while [ $i != "q"]; do
        echo -en "Enter your selection: "
        read i
        case $i in
        "1")
        list_items
        ;;
        "2")
        add_item
        ;;
        "3")
        edit_item
        ;;
        "4")
        remove_item
        ;;
        "q")
        echo "Quitting"
        exit 0
        ;;
        *)
        echo "Unexpected input"
        ;;
        esac
}

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

menu