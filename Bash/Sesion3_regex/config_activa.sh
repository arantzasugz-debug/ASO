#!/bin/bash

if [[ $# -eq 0 ]]; then
    fichero=/etc/login.defs
else 
    fichero=$1
fi

if [[ ! -f $fichero ]]; then
     echo "Error: el fichero $fichero no existe"
     exit 1
fi

re1='^#'
re2='^$'
total=0
util=0

while read -r linea; do 
     ((total++))
     if ! [[ $linea =~ $re1 || $linea =~ $re2 ]]; then
         echo "$linea"
          ((util++))
    fi
done < "$fichero"

echo "----"
echo "Lineas totales: $total"
echo "Lineas utiles: $util"
