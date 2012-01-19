#!/bin/sh
create () {
	patientID=$1
	patientAlertType=$2
	for (( i = 0; i <= 50; i++ ))
	do
		Date="date -v-"$i"d \"+%Y-%m-%dT%H:%M:%S\""
		Date=`eval $Date`
		params="{\"type\": \"Alert\",\"name\": \"Meet the doctor in your HIV clinic as soon as possible[Generated by Script]\",\"priority\": 3,\"data\": {\"ConnectedToDoctor\": \"n/a\",\"PatientAlertType\": \"$patientAlertType\",\"Symptoms Alert Status\": \"Closed\",\"Patient Call Preference\": \"Daily\",\"Notes\": \"some notes\"},\"status\": \"READ\",\"description\": \"Nausea or Vomiting, Breathlessness or Giddiness.\",\"externalId\": \"$patientID\",\"dateTime\": \"$Date.354+05:30\",\"alertType\": \"HIGH\"}"
		echo $params > params.txt
		curl -X POST "http://localhost:5984/motech-alert" -H "Content-Type: application/json" -d @params.txt
	done
}

if [ -z "$1" ]
then
	echo "[ERROR]: Please provide Patient Document ID"
	echo "Usage: ./alerts-generator.sh <PatientDocumentID>"
	echo "Example: ./alerts-generator.sh b7bceb7a369445239d590a27d992f25b"
	exit 3
fi

create $1 "AdherenceInRed"
create $1 "SymptomReporting"
create $1 "FallingAdherence"

rm params.txt
