json.array!(@collector_versions) do |collector_version|
  json.extract! collector_version, :id, :version
end
