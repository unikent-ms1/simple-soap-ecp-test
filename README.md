Simple SOAP ECP Test
====================

This simple script performs a test on a Basic Auth protected SAML2 ECP endpoint.

Based on original work from http://blogs.kent.ac.uk/unseenit/simple-shibboleth-ecp-test/

Usage
-----

The script defaults to impersonating an Office365 Azure based SP. Override by specifying the EntityID of the SP you wish to impersonate in the ```ENTITYID``` environment variable.

You also need to specify the registered endpoint that the request is pretending to come from. Again, this defaults to the Office365 endpoint. This is the URL specified in the metadata of the SP you’re impersonating for the AssertionConsumerService attribute with binding ```urn:oasis:names:tc:SAML:2.0:bindings:PAOS```. Override with ```ENDPOINT```.

You **MUST** specify a ```URL``` to make the request against. For a Shibboleth IDP this probably looks like ```https://idp.example.com/idp/profile/SAML2/SOAP/ECP```.

Example
-------

*The values for ```ENTITYID``` and ```ENDPOINT``` are the defaults.*

```
CRED=user:pass \
ENTITYID=urn:federation:MicrosoftOnline \
ENDPOINT=https://login.microsoftonline.com/login.srf \
URL=https://idp.example.com/idp/profile/SAML2/SOAP/ECP \
bash test.sh | xmllint --pretty 1 -
```

You can also override the HTTP `Content-Type` in the request by setting
`CONTENT_TYPE` environment variables.
