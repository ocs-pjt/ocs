require 'curb'
require 'benchmark'
require 'json'

### WEBSERVICE 4 ###
data = []
ar = (1..100).to_a
str = ar.join(",")
1.times do
  data << str
end

params = {
  email: "vialette@univ-mlv.fr",
  authentication_key: "GNp72m1Tmu9Hym4a7h6n",
  use_case_key: "abc",
  operating_system: "Windows",
  object: {
    collection_point: "sort",
    data_type: "trace",
    data: data,
    optional: "More Info",
    description: "Desc about collect",
  },
  deferred: {
    date: "2013-12-10",
    postman_name: "ocs",
    postman_version: "1.0.0"
  }
}

Benchmark.bm do |x|
  x.report do
    1.times do
      @http = Curl::Easy.http_post(
        "http://localhost:9292/resources/collect",
        params.to_json
      ) do |curl|
        curl.follow_location = true
        curl.headers['Accept']        = 'application/json'
        curl.headers['Content-Type']  = 'application/json'
        curl.headers['Api-Version']   = '2.2'
      end
    end

    puts "\nBODY RESPONSE: #{@http.body_str}"
  end
end
