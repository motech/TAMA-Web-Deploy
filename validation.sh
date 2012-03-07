#!/bin/bash
equals() {
	#All Envoriments should have same set of property files
	dir -1 ./properties/qa > 1.txt
	RESULT=0
	for env in `ls ./properties`; do
  		dir -1 ./properties/$env > 2.txt
  		diff 1.txt 2.txt -q >/dev/null
  		if [ $? -ne 0 ]; then
			 if [ $RESULT -eq 0 ];then
			   echo "The following environments are different:"
			 fi
   			 echo "\t\t"$env;
			 RESULT=1
  		fi
	done
	rm 1.txt 2.txt
	return $RESULT
}
equals
