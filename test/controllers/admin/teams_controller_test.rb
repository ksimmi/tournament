require 'test_helper'

class Admin::TeamsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_team = admin_teams(:one)
  end

  test "should get index" do
    get admin_teams_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_team_url
    assert_response :success
  end

  test "should create admin_team" do
    assert_difference('Admin::Team.count') do
      post admin_teams_url, params: { admin_team: { name: @admin_team.name } }
    end

    assert_redirected_to admin_team_url(Admin::Team.last)
  end

  test "should show admin_team" do
    get admin_team_url(@admin_team)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_team_url(@admin_team)
    assert_response :success
  end

  test "should update admin_team" do
    patch admin_team_url(@admin_team), params: { admin_team: { name: @admin_team.name } }
    assert_redirected_to admin_team_url(@admin_team)
  end

  test "should destroy admin_team" do
    assert_difference('Admin::Team.count', -1) do
      delete admin_team_url(@admin_team)
    end

    assert_redirected_to admin_teams_url
  end
end
