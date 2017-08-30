json.array!(@services) do |service|
  json.extract! service, :id, :publication_id
  json.url service_url(service, format: :json)
end
