json.array!(@issues) do |issue|
  json.extract! issue, :id, :repository_id, :name, :severity, :description, :reference_url, :dependency
  json.url issue_url(issue, format: :json)
end
