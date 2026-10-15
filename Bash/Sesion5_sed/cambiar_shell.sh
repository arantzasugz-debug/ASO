#!/bin/bash

usuario=$1
shell=$2

if [[ $# -eq 2 ]]; then
 echo "Uso: $0 de parametros"
 exit 1
fi

if grep -q "^usuario:" /etc/passwd-; then
    echo "El usuario existe"
else
    echo "El usuario NO existe"
fi

re='^/bin/(bash|sh|zsh)$' /etc/passwd-

sed -i.bak -E 's|^usuario:([^:]+:){5}/bin/[^:]+$|usuario:\1/bin/bash|' /etc/passwd- && grep 