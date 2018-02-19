require "application_system_test_case"

class GamesTest < ApplicationSystemTestCase
  test "Going to /new gives us a new random grid to play with" do
    visit new_url
    assert test: "New game"
    assert_selector "li", count: 10
  end

  test "Filling in the form with random letters does not match the grid" do
    visit new_url
    fill_in "answer", with: "abcdefghin"
    click_on "play"
    assert_selector "p", text: "Sorry, ABCDEFGHIN can't be built out of the grid"
  end

  test "Filling in the form with a word that is not English" do
    visit new_url
    fill_in "answer", with:
    click_on "play"
    assert_selector "p", text: "Sorry but U does not seem to be a valid English word"
  end

  test "Filling in the form with a word that is English" do
    visit new_url
    fill_in "answer", with: "a"
    click_on "play"
    assert_selector "p", text: "Congratulations! A is a valid English word! And your score is 1"
  end

end
