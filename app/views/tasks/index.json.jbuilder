json.array!(@tasks) do |task|
  json.extract! task, :id, :user_id, :file
  json.url task_url(task, format: :json)
end
