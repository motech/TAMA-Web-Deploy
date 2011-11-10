#!/usr/bin/python

import couchdb
import uuid

couch = couchdb.Server()

db = couch['tama-web']

for id in db:
	doc = db[id]
	if "documentType" in doc and doc["documentType"] == "Patient":
		doc["mobilePhoneNumber"] = "000000" + doc["mobilePhoneNumber"][ len(doc["mobilePhoneNumber"]) - 4 : ]
		doc["patientPreferences"]["passcode"] = "0000"
		db[doc.id] = doc
	if "documentType" in doc and doc["documentType"] == "UniquePatientField":
		old_doc = doc
		prefix = "Constraint:Unique:PhoneNumber/Passcode::"
		if prefix in doc.id:
			mobileNumber = doc.id.split("::")[1].split("/")[0]
			db.delete(old_doc)
			del doc["_rev"]
			doc["_id"] = prefix + "000000" + mobileNumber[ len(mobileNumber) - 4 : ] + "/0000"
			db.create(doc)

