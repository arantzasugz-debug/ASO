#!/bin/bash

contador=0

while read -r linea; do
 if [[ "$linea" =~ bash$ ]]; then
  usuario="${linea%%:*}"
  echo "$usuario"
  contador=$((contador + 1))
  fi
done < /etc/passwd 

echo "----"
echo "usuarios con bash: $contador"
