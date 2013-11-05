json.array!(@use_cases) do |use_case|
  json.extract! use_case, :key, :user_id, :collector_id, :collector_version_id, :program_id, :program_version_id
  json.url use_case_url(use_case, format: :json)
end
