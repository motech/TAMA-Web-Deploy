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
		doc["status"] = "Inactive"
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
	if "documentType" in doc and doc["documentType"] == "CallLog":
		doc["phoneNumber"] = "000000" + doc["phoneNumber"][ len(doc["phoneNumber"]) - 4 : ]
		db[doc.id] = doc
	if "documentType" in doc and doc["documentType"] == "IVRCallAudit":
		doc["cid"] = "000000" + doc["cid"][ len(doc["cid"]) - 4 : ]
		db[doc.id] = doc
	if "documentType" in doc and doc["documentType"] == "Clinician":
		doc["contactNumber"] = "000000" + doc["contactNumber"][ len(doc["contactNumber"]) - 4 : ]
		if "alternateContactNumber" in doc and len(doc["alternateContactNumber"]) > 0:
			doc["alternateContactNumber"] = "000000" + doc["alternateContactNumber"][ len(doc["alternateContactNumber"]) - 4 : ]
		db[doc.id] = doc
	if "documentType" in doc and doc["documentType"] == "Clinic":
		doc["phone"] = "000000" + doc["phone"][ len(doc["phone"]) - 4 : ]
		for clinicianContact in doc["clinicianContacts"]:
			clinicianContact["phoneNumber"] = "000000" + clinicianContact["phoneNumber"][ len(clinicianContact["phoneNumber"]) - 4 : ]
		db[doc.id] = doc



db = couch['motech-ivr-kookoo']

for id in db:
	doc = db[id]
	if "type" in doc and doc["type"] == "KookooCallDetailRecord":
		doc["callDetailRecord"]["phoneNumber"] = "000000" + doc["callDetailRecord"]["phoneNumber"][ len(doc["callDetailRecord"]["phoneNumber"]) - 4 : ]
		db[doc.id] = doc

