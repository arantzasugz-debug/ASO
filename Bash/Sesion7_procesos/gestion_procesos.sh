#!/bin/bash

listar_usuario() {
   read - p "Introduce el nombre de usuario" usuario
   if id "$usuario" >/dev/null 2>&1; then
       ps -u "usuario"
   else
       echo "Error: el usuario '$usuario' no existe."
   fi
}

buscar_procesos() {
     
    
}

top_cpu() {
     echo 
}

cambiar_prioridad() {

}

finalizar_proceso() {

}

while  true; do
echo "===== GESTIÓN DE PROCESOS ====="
echo "1) Listar los procesos de un usuario"
echo "2) Buscar un proceso por nombre"
echo "3) Mostrar los N procesos que más CPU consumen"
echo "4) Cambiar la prioridad de un proceso"
echo "5) Finalizar un proceso"
echo "6) Salir"
read -p "Introduzca la opcion: " opcion

case $opcion in 
1) listar_usuario;;
2) buscar_procesos;;
3) top_cpu;;
4) cambiar_prioridad ;;
5) finalizar_proceso ;;
6) echo "Saliendo del gestor de procesos:"; exit  ;;
*) echo "ERROR: opcion no reconocida" ;;
esac
done