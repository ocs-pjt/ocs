json.array!(@collectors) do |collector|
  json.extract! collector, :name, :file
  json.url collector_url(collector, format: :json)
end
