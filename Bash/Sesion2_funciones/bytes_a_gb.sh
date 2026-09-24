#!/bin/bash

bytes_a_gb() {
	 local bytes=$1
	  echo "scale=2; $bytes / 1073741824" | bc
}


bytes_a_gb 5000000000
bytes_a_gb 1073741824
