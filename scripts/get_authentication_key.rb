require 'curb'
require 'benchmark'

### WEBSERVICE 3 ###
params = 
  [
    '{"email": "vialette@univ-mlv.fr"', 
    '"password": "toto"}'
  ].join(", ")

@http = Curl::Easy.http_post(
  "http://localhost:9292/users/authentication_key",
  params
) do |curl|
  curl.headers['Accept']        = 'application/json'
  curl.headers['Content-Type']  = 'application/json'
  curl.headers['Api-Version']   = '2.2'
end

puts "\nBODY RESPONSE: #{@http.body_str}"
