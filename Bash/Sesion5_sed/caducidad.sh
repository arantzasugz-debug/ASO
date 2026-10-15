#!/bin/bash

dias=$1
fichero=login.defs


re='[0-9]{1-3}$'

if [[ $# -eq 0 ]]; then
  echo "Uso: $0 de fichero"
  exit 1
fi

if [[ $1 =~ $re ]]; then
     eho "Error: $dias no es un numero de dias valido"
fi

sed -E "s/^PASS_MAX_DAYS.*/PASS_MAX_DAYS $dias/"
