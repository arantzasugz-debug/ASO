#!bin/bash 

servicio=$1

if [[ -z $servicio ]];then 
	 echo "Debes indicar el nombre del servicio" 
else
	 echo "iniciando el servicio $servicio..."
fi

