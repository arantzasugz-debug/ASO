#!/bin/bash

for entrada in ~/ASO/Bash/prueba_bash/*; do
 if [[ -e "$entrada" ]]; then
	 nombre=$(basename "$entrada")
	 if [[ -f "$entrada" ]]; then
	 	 echo "$nombre fichero"
	 elif [[ -d "$entrada" ]]; then 
 		 echo "$nombre directorio"
 	fi
 fi
done

