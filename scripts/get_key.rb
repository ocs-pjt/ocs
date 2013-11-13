require 'curb'
require 'benchmark'

### WEBSERVICE 1 ###

params = 
  [
    '{"email": "test@test.com"', 
    '"authentication_key": "YWyHE936yyeMAV9jvKDE"', 
    '"collector_name": "RUBY"',
    '"tags": "Biology, Genomic, Something stupid, Something stupid4"}'
  ].join(", ")


Benchmark.bm do |x|
  x.report do
    @http = Curl::Easy.http_post(
      "http://localhost:3000/use_cases/get_key",
      params
    ) do |curl|
      curl.headers['Accept']        = 'application/json'
      curl.headers['Content-Type']  = 'application/json'
      curl.headers['Api-Version']   = '2.2'
    end
    puts "<br/>"
  end
end

puts "<br/><br/>#{@http.body_str}"

