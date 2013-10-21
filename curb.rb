require 'curb'
require 'benchmark'

data = ""

ar = (1..500).to_a
9999.times do
  str = ar.shuffle.join(",")
  data << '{"name": "qsort", "permutation":"' << str << '"},'
end
data << '{"name": "mergesort", "permutation": "1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3"}'

Benchmark.bm do |x|

  x.report do
    @http = Curl::Easy.http_post(
      "http://localhost:3000/permutations/collect",
      '{ "auth_token": "abc", "data": [' + data + ']}'
    ) do |curl|
      curl.headers['Accept'] = 'application/json'
      curl.headers['Content-Type'] = 'application/json'
      curl.headers['Api-Version'] = '2.2'
    end
  end
  puts @http.body_str

end
