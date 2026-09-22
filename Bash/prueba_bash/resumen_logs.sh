#!/bin/bash
carpeta=$1

for fichero in "$carpeta"/*.log; do
	 nombre=$(basename "$fichero")
	 warnings=$(grep -c "WARNING" "$fichero")
	 errores=$(grep -c "ERROR" "$fichero")
 	echo "$nombre $warnings WARNING; $errores ERROR"
done
