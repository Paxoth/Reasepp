json.array!(@projects) do |project|
  json.extract! project, :id, :title, :description, :faculty, :department, :course_name, :course_type, :course_type_other, :professor_name, :professor_phone, :learning_objectives, :service_objectives, :frequency, :weekly_hours, :students_level, :community_partner, :organization_type, :benefit, :results, :tools, :reflection_moments, :period, :professor_degree, :participants, :institutional_support, :area_id, :user_id, :institution_id, :start_time, :end_time, :partner
  json.url project_url(project, format: :json)
end
