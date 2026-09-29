#!/bin/bash


re1='\.conf$'
re2='\.bak$'
conf=0
copias=0

for fichero in /etc/*; do
 if [[ $fichero =~ $re1 ]]; then
  echo "$fichero"
  conf=$((conf + 1))
  else 
  if [[ $fichero =~ re2 ]]; then
    copias=$((copias + 1))
    echo "$fichero"
  fi
 fi
done

echo "Configuracion: $conf"
echo "Copias de seguridad: $copias"
