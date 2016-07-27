#!/usr/bin/python

from rauth import OAuth1Service
import requests
import logging
import httplib
import time

# this uses the Rauth package, derived from the Requests package
# Rauth: http://rauth.readthedocs.org/en/latest/
# Requests: http://docs.python-requests.org/en/latest/

print username 
print userpass 
print consumer_key 
print consumer_secret 
print request_token_url 
print authorize_token_url 
print access_token_url 


debug = True



if debug:
    httplib.HTTPConnection.debuglevel = 1
    logging.basicConfig() 
    logging.getLogger().setLevel(logging.DEBUG)
    requests_log = logging.getLogger("requests.packages.urllib3")
    requests_log.setLevel(logging.DEBUG)
    requests_log.propagate = True
    
service = OAuth1Service(
    consumer_key = consumer_key,
    consumer_secret = consumer_secret,
    request_token_url = request_token_url,
    authorize_url = authorize_token_url,
    access_token_url = access_token_url)

print username

# stage one: get the request token
request_token, request_token_secret = service.get_request_token(params={'oauth_callback': 'oob'})

service.get_request_token(params={'oauth_callback': 'oob'})
print 'request_token'
print request_token
print 'request_token_secret'
print request_token_secret

# stage two: have the user authorize
# NOTE: We call rauth's get_authorize_url even though we will ignore the results
#       because etrade's url is not standard. We must call this method because
#       doing so sets some state within the service object that it needs later.
junk = service.get_authorize_url(request_token)
# now build the real auth request url. user must visit this url. eventually, he
# will be presented with a code, usually 5 characters, to enter as the verifier.
authorize_url = authorize_token_url + '?' + 'key=' + \
    consumer_key + '&' + 'token=' + request_token
    
print  authorize_url









