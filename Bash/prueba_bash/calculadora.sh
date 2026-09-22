
#!/bin/bash
sumar() {
    echo $(($1 + $2))
}

restar() {
    echo $(($1 - $2))
}

multiplicar() {
    echo $(($1 * $2))
}

dividir() {
    if [[ $2 -eq 0 ]]; then
        echo "Error: división por cero"
    else
        echo "scale=2; $1 / $2" | bc
    fi
}

mostrar_menu() {
echo""
echo "calculadora"
echo "1) Sumar"
echo "2) Restar"
echo "3) Multiplicar"
echo "4) Dividir"
echo "0) Salir"
}

while true; do 
	 mostrar_menu
	 read -p "Elige una opcion: " opcion

	 if [[ $opcion -eq 0 ]]; then
	      echo "Saliendo..."
	     break
	 fi

read -p "introduce el primer numero: " num1
read -p "introduce el segundo numero: " num2

case $opcion in 
	 1)
	 resultado=$(sumar "$num1" "$num2")  
	 ;;
	 2)
	 resultado=$(restar "$num1" "$num2")
	 ;;
	 3)
	 resultado=$(multiplicar "$num1" "$num2")
	 ;;
	 4)
	 resultado=$(dividir "$num1" "$num2")
	 ;;
	 *)
	 echo "opcion no encontrada"
	 ;;
esac

echo "Resultado: $resultado"
done


