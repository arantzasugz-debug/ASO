#!/bin/bash

re="^[a-z][a-z0-9]*$"
while true; do
read -p "Nombre del usuario: " usuario
 if [[ ! "$usuario" =~ $re ]]; then
  echo "No es válido. Debe empezar por minúscula y tener solo minúsculas o dígitos."
  continue
 fi
  
 if id "$usuario" &>/dev/null; then
    echo "El usuario $usuario ya existe."
    break
 else 
   echo "Para crearlo: sudo useradd -m -s /bin/bash $usuario"
   break
 fi
done 



