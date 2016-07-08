#!/bin/bash

### Simple SOAP ECP Test

TEMPLATE=template.xml
NOW=$(date -u '+%FT%H:%M:%SZ')
ID=$(echo "${NOW}-$$" | shasum | cut -d ' ' -f 1)
ENTITYID=${ENTITYID:-urn:federation:MicrosoftOnline}
ENDPOINT=${ENDPOINT:-https://login.microsoftonline.com/login.srf}
URL=${URL:-http://localhost/}

CRED=${CRED:-anonymous:anonymous}

ENDPOINT_ESCAPED="$(echo $ENDPOINT | sed -e 's/[\/&]/\\&/g')"

REQUEST=$(cat $TEMPLATE |
	sed "s/__NOW__/$NOW/" |
	sed "s/__RANDOM_STRING__/$ID/" |
	sed "s/__REMOTE_ENTITYID__/$ENTITYID/" |
	sed "s/__AssertionConsumerServiceURL__/$ENDPOINT_ESCAPED/")

echo $REQUEST | xmllint --pretty 1 -

echo $REQUEST |
	curl -k \
		-d @- \
		-H "Content-Type: application/vnd.paos+xml" \
		--basic -u $CRED \
		$URL 
