json.extract! task, :id, :title, :due_time, :status, :created_at, :updated_at
json.url task_url(task, format: :json)
