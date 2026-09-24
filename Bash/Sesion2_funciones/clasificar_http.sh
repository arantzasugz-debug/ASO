#!/bin/bash

clasificar_http() {
	local codigo=$1
	if [[ $codigo -ge 200 && $codigo -le 299 ]]; then
 	echo "Exito"
	 elif [[ $codigo -ge 300 && $codigo -le 399 ]]; then
	 echo "Redireccion"
	 elif [[ $codigo -ge 400 && $codigo -le 499 ]]; then
	 echo "Error del cliente"
	 elif [[ $codigo -ge 500 && $codigo -le 599 ]]; then
	 echo "Error del servidor"
	 else 
	 echo "codigo desconocido" 
	 fi
}

clasificar_http 200
clasificar_http 301
clasificar_http 404
clasificar_http 500

