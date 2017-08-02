json.array!(@institutions) do |institution|
  json.extract! institution, :id, :name, :web
  json.url institution_url(institution, format: :json)
end
