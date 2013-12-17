require "test_helper"

class BrandingTest < Capybara::Rails::TestCase

  test "visit different restaurants and see different branding and items" do
    visit root_path
    assert page.has_content?('Welcome to Noshify!')
    click_on "Denver"
    click_on "KFC"

    assert_equal restaurant_root_path(restaurants(:one)), current_path

    within '#restaurant-title' do
        assert page.has_content?("KFC")
    end

    assert page.has_content?("Mashed Potatoes")


    visit root_path
    click_on "Washington D.C."
    click_on "McDonalds"
    assert_equal restaurant_root_path(restaurants(:two)), current_path
    within '#restaurant-title' do
        assert page.has_content?("McDonalds")
    end
    assert page.has_content?("Big Mac")
    refute page.has_content?("Mashed Potatoes")

  end
end
