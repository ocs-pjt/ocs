require 'curb'
require 'benchmark'

### WEBSERVICE 4 ###
data = ""
ar = (1..10000).to_a
str = ar.join(",")
999.times do
  data << '{"data":"' << str << '"},'
end
data << '{"data": "' + str + '"}'

params = 
  [
    '{"email": "vialette@univ-mlv.fr"', 
    '"authentication_key": "GNp72m1Tmu9Hym4a7h6n"', 
    '"use_case_key": "abc"',
    '"items": [' + data + ']}'
  ].join(", ")


Benchmark.bm do |x|
  x.report do
    1.times do
      @http = Curl::Easy.http_post(
        "http://localhost:9292/traces/collect",
        params
      ) do |curl|
        curl.headers['Accept']        = 'application/json'
        curl.headers['Content-Type']  = 'application/json'
        curl.headers['Api-Version']   = '2.2'
      end
    end

    puts "\nBODY RESPONSE: #{@http.body_str}"
  end
end
