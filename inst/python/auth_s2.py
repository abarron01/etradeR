#!/usr/bin/python
import sys

# this uses the Rauth package, derived from the Requests package
# Rauth: http://rauth.readthedocs.org/en/latest/
# Requests: http://docs.python-requests.org/en/latest/

debug = True
 


# stage three: fetch the access token
access_token, access_token_secret = service.get_access_token(request_token, request_token_secret,
                                                             params={'oauth_verifier': oauth_verifier})
print ("step 1")
# stage four: create the session
session = service.get_session((access_token, access_token_secret))

print "*** session established"

# we now have a working session. use it to fetch data.
#accounts_raw = session.get('https://etwssandbox.etrade.com/accounts/sandbox/rest/accountlist.json')
#print accounts_raw
