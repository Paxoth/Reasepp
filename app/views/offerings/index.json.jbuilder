json.array!(@offerings) do |offering|
  json.extract! offering, :id, :user_id, :experience_id, :community_id, :area_id, :title, :description, :status, :start_time, :end_time
  json.url offering_url(offering, format: :json)
end
