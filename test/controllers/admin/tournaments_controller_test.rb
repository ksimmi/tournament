require 'test_helper'

class Admin::TournamentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tournament = admin_tournaments(:one)
  end

  test "should get index" do
    get admin_tournaments_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_tournament_url
    assert_response :success
  end

  test "should create admin_tournament" do
    assert_difference('Admin::Tournament.count') do
      post admin_tournaments_url, params: { admin_tournament: {  } }
    end

    assert_redirected_to admin_tournament_url(Admin::Tournament.last)
  end

  test "should show admin_tournament" do
    get admin_tournament_url(@tournament)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_tournament_url(@tournament)
    assert_response :success
  end

  test "should update admin_tournament" do
    patch admin_tournament_url(@tournament), params: { admin_tournament: {  } }
    assert_redirected_to admin_tournament_url(@tournament)
  end

  test "should destroy admin_tournament" do
    assert_difference('Admin::Tournament.count', -1) do
      delete admin_tournament_url(@tournament)
    end

    assert_redirected_to admin_tournaments_url
  end
end
