#!/bin/bash
#This script change a host file to block some file 

#!/bin/bash

a_arg=""
s_arg=""
r_arg=""

host_path="../tests_file/tests_hosts/hosts"
host_path_backup=$host_path".bak"

#create backup 
if [ ! -e "$host_path_backup" ]; then
    echo "Create backup: $host_path_backup"
    cat $host_path > $host_path_backup
fi

while getopts "a:s:r" opt; do
    case $opt in
        a)
            a_arg=$OPTARG
            if [ -n "$s_arg" ] || [ -n "$r_arg" ]; then
                echo "Error : Use one flag."
                exit 1
            fi
            #check arg
            if [ "$#" -ne 2 ]; then
                echo "Usage: $0 -a <arg> | -s <arg> | -r"
                exit 1
            fi
            #check if domain is already blocked
            cat $host_path | grep $a_arg > /dev/null
            if [ $? -eq 0 ]; then
                echo "A domain $a_arg is already blocked"
                exit 0
            fi
            echo "$a_arg add in host"
            echo "127.0.0.1 $a_arg" >> $host_path
            exit 0
            ;;
        s)
            s_arg=$OPTARG
            if [ -n "$a_arg" ] || [ -n "$r_arg" ]; then
                echo "Error : Use one flag."
                exit 1
            fi
            if [ "$#" -ne 2 ]; then
                echo "Usage: $0 -a <arg> | -s <arg> | -r"
                exit 1
            fi
            echo "$s_arg remove to hosts"
            sed -i "/${s_arg}/d" $host_path
            #Don't work why?
            if [ $? -eq 1 ]; then
                echo "Domain can't be removed"
                exit 1
            fi
            exit 0
            ;;
        r)
            r_arg=$OPTARG
            if [ -n "$a_arg" ] || [ -n "$s_arg" ]; then
                echo "Error : Use one flag."
                exit 1
            fi
            echo "Recovery initial hosts"
            cat $host_path_backup > $host_path
            exit 0
            ;;
        \?)
            echo "Invalid option : -$OPTARG" >&2
            exit 1
            ;;
        :)
            echo "Need arg -$OPTARG" >&2
            exit 1
            ;;
    esac
done
