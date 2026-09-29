#!/bin/bash
puerto=$1

re='^[0-9]+$'
if [[ $puerto =~ $re ]]; then

     if [[ $puerto -ge 1 && $puerto -le 65535 ]]; then
     echo "$puerto es un puerto valido"
     else 
     echo "$puerto esta fuera de rango (1-65535)"
     fi
else 
     echo "No es un numero"
fi

