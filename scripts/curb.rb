require 'curb'
require 'benchmark'

data = ""

ar = (1..100).to_a
1.times do
  str = ar.shuffle.join(",")
  data << '{"name": "qsort", "permutation":"' << str << '"},'
end
data << '{"name": "mergesort", "permutation": "1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3"}'

Benchmark.bm do |x|

  x.report do
    @http = Curl::Easy.http_post(
      "http://localhost:9292/permutations/collect",
      '{ "user_email": "test@test.com", "authentication_key": "kSN4kfsDqGYwNZGhQBgM", "data": [' + data + ']}'
    ) do |curl|
      curl.headers['Accept'] = 'application/json'
      curl.headers['Content-Type'] = 'application/json'
      curl.headers['Api-Version'] = '2.2'
    end
  end
  puts @http.body_str

end
