#!/bin/bash

n=$1
re='^[0-9]+$'
if [[ -n "$n" ]]; then
     if [[ ! "$n" =~ $re ]]; then
         echo "ERROR: $n no es un numero"
         exit 1
    fi
fi

 ps -u "$USER" -o pid,pcpu,pmem,comm --sort=-pcpu

 if [[ -n "$n" ]];then
     head -n $((n + 1)) procesos.txt
else
    cat procesos.txt
fi

total_procesos=$(ps -u "$USER" --no-headers | wc -l)
echo "Procesos de $USER: $total_procesos"

