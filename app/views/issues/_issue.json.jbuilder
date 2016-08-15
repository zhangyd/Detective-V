json.extract! issue, :id, :severity, :source, :description, :detail, :fingerprint, :scan_id, :created_at, :updated_at
json.url issue_url(issue, format: :json)