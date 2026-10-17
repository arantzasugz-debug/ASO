#!/bin/bash

dias=$1
fichero="login.defs"


re='^[0-9]{1,3}$'

if [[ $# -eq 0 ]]; then
  echo "Uso: $0 de fichero"
  exit 1
fi

if ! [[ $dias =~ $re ]]; then
     eho "Error: $dias no es un numero de dias valido"
     exit 1
fi

fi [[ ! -f "$fichero" ]]; then
   echo "Error: No se encuentra el fichero $fichero"
   exit 1
fi

valor_anterior=$(grep -E "^PASS_MAX_DAYS" "$fichero")
sed -i.bak -E "s/^PASS_MAX_DAYS.*/PASS_MAX_DAYS $dias/" "$fichero"

valor_nuevo=$(grep -E "^PASS_MAX_DAYS" "$fichero")

echo "Antes: $valor_anterior"
echo "Despues: $valor_nuevo"