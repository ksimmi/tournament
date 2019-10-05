require "application_system_test_case"

class Admin::TournamentsTest < ApplicationSystemTestCase
  setup do
    @tournament = admin_tournaments(:one)
  end

  test "visiting the index" do
    visit admin_tournaments_url
    assert_selector "h1", text: "Admin/Tournaments"
  end

  test "creating a Tournament" do
    visit admin_tournaments_url
    click_on "New Admin/Tournament"

    click_on "Create Tournament"

    assert_text "Tournament was successfully created"
    click_on "Back"
  end

  test "updating a Tournament" do
    visit admin_tournaments_url
    click_on "Edit", match: :first

    click_on "Update Tournament"

    assert_text "Tournament was successfully updated"
    click_on "Back"
  end

  test "destroying a Tournament" do
    visit admin_tournaments_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Tournament was successfully destroyed"
  end
end
