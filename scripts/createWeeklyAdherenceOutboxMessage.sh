#usage sh createWeeklyAdherenceOutboxMessage.sh id



curl -X POST http://127.0.0.1:5984/motech-outbox -H "Content-Type: application/json" -d '{"partyId" : "'$1'","creationTime" : "2012-02-01T10:36:42.517+0000","expirationDate":"2212-02-07T18:30:00.000+0000","status":"PENDING","voiceMessageType":{"voiceMessageTypeName":"AudioCommand","priority":"LOW","templateName":"temp","canBeSaved":"true","canBeReplayed":"true"}}'
