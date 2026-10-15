#!/bin/bash
if [[ $# -eq 0 ]]; then
 echo "Uso: $0 mac"
 exit 1
fi

re='^([0-9a-fA-F]{2}[\:|\-]){5}[0-9a-fA-F]{2}$' 

if [[ $1 =~ $re ]]; then 
   echo "$1 es una MAC valida"
 else 
   echo "$1 no es una MAC valida"
fi

