require 'curb'
require 'benchmark'

### WEBSERVICE 1 ###
params = 
  [
    '{"email": "vialette@univ-mlv.fr"', 
    '"authentication_key": "GNp72m1Tmu9Hym4a7h6n"', 
    '"collector_name": "RUBY"',
    '"collector_version": "1.0.0"',
    '"program_name": "Word"',
    '"tags": "Biology, Genomic, Mathematic, Info"}'
  ].join(", ")


Benchmark.bm do |x|
  x.report do
    @http = Curl::Easy.http_post(
      "http://localhost:9292/use_cases/get_key",
      params
    ) do |curl|
      curl.headers['Accept']        = 'application/json'
      curl.headers['Content-Type']  = 'application/json'
      curl.headers['Api-Version']   = '2.2'
    end
    puts "\n"
  end
end

puts "\n#{@http.body_str}"

