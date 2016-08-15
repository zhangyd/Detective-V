json.extract! repo, :id, :name, :owner, :full_name, :html_url, :description, :language, :size, :created_at, :updated_at
json.url repo_url(repo, format: :json)