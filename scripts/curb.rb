require 'curb'
require 'benchmark'

data = ""

ar = (1..200).to_a
99.times do
  str = ar.join(",")
  data << '{"function": "qsort", "data":"' << str << '"},'
end
data << '{"function": "mergesort", "data": "1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3"}'

params = 
  [
    '{"email": "test@test.com"', 
    '"authentication_key": "YWyHE936yyeMAV9jvKDE"', 
    '"use_case_key": "abc"',
    '"items": [' + data + ']}'
  ].join(", ")


Benchmark.bm do |x|
  x.report do

    100.times do
      @http = Curl::Easy.http_post(
        "http://localhost:9292/permutations/collect",
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
