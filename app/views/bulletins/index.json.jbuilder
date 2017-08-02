json.array!(@bulletins) do |bulletin|
  json.extract! bulletin, :id, :title, :description, :start_date
  json.url bulletin_url(bulletin, format: :json)
end
