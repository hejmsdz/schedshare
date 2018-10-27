json.extract! binary, :id, :version, :user_id, :created_at
json.url rails_blob_url(binary.file)
