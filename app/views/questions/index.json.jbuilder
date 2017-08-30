json.array!(@questions) do |question|
  json.extract! question, :id, :title, :answer, :reader
  json.url question_url(question, format: :json)
end
