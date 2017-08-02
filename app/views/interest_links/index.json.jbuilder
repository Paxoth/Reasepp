json.array!(@interest_links) do |interest_link|
  json.extract! interest_link, :id, :name, :url, :description
  json.url interest_link_url(interest_link, format: :json)
end
