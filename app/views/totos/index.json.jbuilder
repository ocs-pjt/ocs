json.array!(@totos) do |toto|
  json.extract! toto, :test, :titi, :tutu
  json.url toto_url(toto, format: :json)
end
