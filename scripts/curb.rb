require 'curb'
require 'benchmark'

data = ""

ar = (1..100).to_a
999.times do
  str = ar.join(",")
  data << '{"name": "qsort", "permutation":"' << str << '"},'
end
data << '{"name": "mergesort", "permutation": "1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3"}'

Benchmark.bm do |x|
  x.report do
    @http = Curl::Easy.http_post(
      "http://localhost:9292/permutations/collect",
      '{ "email": "test@test.com", "authentication_key": "YWyHE936yyeMAV9jvKDE", "collector_name": "ruby", "program_name": "Excel", "tags": "Biology,Genetic", "data": [' + data + ']}'
    ) do |curl|
      curl.headers['Accept'] = 'application/json'
      curl.headers['Content-Type'] = 'application/json'
      curl.headers['Api-Version'] = '2.2'
    end
  end


  puts @http.body_str

end
