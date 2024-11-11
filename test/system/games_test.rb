require "application_system_test_case"

class GamesTest < ApplicationSystemTestCase
  test "Going to /new gives us a new random grid to play with" do
    visit new_url
    assert test: "New game"
    assert_selector "li", count: 10
  end

  test "Tu peux remplir le formulaire avec un mot au hasard, cliquer sur le bouton pour jouer et obtenir un message indiquant que le mot n’est pas dans la grille." do
    visit new_url
    fill_in('word', with: 'Canard')
    click_on('Play')
    assert_text "Sorry but CANARD can't be built out of"
  end

end
