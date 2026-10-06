#!/bin/bash

if [[ $# -eq 0 ]]; then
 echo "Uso: $0 IPv4"
 exit 1
fi

re='^([0-9]{1,3}\.){3}[0-9]{1,3}$'

if [[ $1 =~ $re ]]; then 
   echo "$1 tiene formato de IP"
 else 
   echo "$1 no tiene formato de IP"
fi

