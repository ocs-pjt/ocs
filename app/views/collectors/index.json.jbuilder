json.array!(@collectors) do |collector|
  json.extract! collector, :name
end
