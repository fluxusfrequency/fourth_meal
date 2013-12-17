require './test/test_helper'

class AddAndEditItemTest < Capybara::Rails::TestCase

  def test_stocker_can_create_an_item
    skip
    visit root_path
    click_on "KFC"
    assert page.has_content?('Kentucky Fried Wonder')
 
    # click_on "Sign up or Log in"

    # within "#" do
    #   fill_in "Email", with: 'benji@example.com'
    #   fill_in "Password", with: 'password'
    #   click_button ""
    # end

    # assert_content page, 'Logged in'
    click_on "Dashboard"
    assert page.has_content?("Stocker Dashboard")
    click_on "Create New Item"
    assert page.has_content?("Add a new menu item")
    fill_in "Title", with: "Sample Item"
    fill_in "Description", with: "Awesome"
    fill_in "Price", with: "7"
    select "Entrees", from: "Category"
    assert page.has_content?("Retired?")
    click_on "Create Item"

    visit '/onoburrito'

    assert page.has_content?("Sample Item")

  end

end
