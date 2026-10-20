#!/bin/bash

re='^(/[a-z]+)+$'
shell_buscada="${1:-/bin/bash}"

if [[ ! "$shell_buscada" =~ $re ]]; then
    echo "Error: $shell_buscada no es una ruta valida" 
    exit 1
fi

contador_total=0
contador_mayores=0

while IFS=':' read -r usuario x uid gid desc home shell; do

if [[ "$shell" == "$shell_buscada" ]]; then 
     echo "$usuario:$uid:$home:$shell"
     ((contador_total++))
     if [[ "$uid" -ge 1000 ]]; then
         ((contador_mayores++))
    fi 
fi
done < /etc/passwd

echo "Cuentas listadas: $contador_total"
echo "Con UID >= 1000: $contador_mayores"
