require 'test_helper'

class ProjectsControllerTest < ActionController::TestCase
  setup do
    @project = projects(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:projects)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create project" do
    assert_difference('Project.count') do
      post :create, project: { area_id: @project.area_id, benefit: @project.benefit, community_partner: @project.community_partner, course_name: @project.course_name, course_type: @project.course_type, course_type_other: @project.course_type_other, department: @project.department, description: @project.description, end_time: @project.end_time, faculty: @project.faculty, frequency: @project.frequency, institution_id: @project.institution_id, institutional_support: @project.institutional_support, learning_objectives: @project.learning_objectives, organization_type: @project.organization_type, participants: @project.participants, partner: @project.partner, period: @project.period, professor_degree: @project.professor_degree, professor_name: @project.professor_name, professor_phone: @project.professor_phone, reflection_moments: @project.reflection_moments, results: @project.results, service_objectives: @project.service_objectives, start_time: @project.start_time, students_level: @project.students_level, title: @project.title, tools: @project.tools, user_id: @project.user_id, weekly_hours: @project.weekly_hours }
    end

    assert_redirected_to project_path(assigns(:project))
  end

  test "should show project" do
    get :show, id: @project
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @project
    assert_response :success
  end

  test "should update project" do
    patch :update, id: @project, project: { area_id: @project.area_id, benefit: @project.benefit, community_partner: @project.community_partner, course_name: @project.course_name, course_type: @project.course_type, course_type_other: @project.course_type_other, department: @project.department, description: @project.description, end_time: @project.end_time, faculty: @project.faculty, frequency: @project.frequency, institution_id: @project.institution_id, institutional_support: @project.institutional_support, learning_objectives: @project.learning_objectives, organization_type: @project.organization_type, participants: @project.participants, partner: @project.partner, period: @project.period, professor_degree: @project.professor_degree, professor_name: @project.professor_name, professor_phone: @project.professor_phone, reflection_moments: @project.reflection_moments, results: @project.results, service_objectives: @project.service_objectives, start_time: @project.start_time, students_level: @project.students_level, title: @project.title, tools: @project.tools, user_id: @project.user_id, weekly_hours: @project.weekly_hours }
    assert_redirected_to project_path(assigns(:project))
  end

  test "should destroy project" do
    assert_difference('Project.count', -1) do
      delete :destroy, id: @project
    end

    assert_redirected_to projects_path
  end
end
