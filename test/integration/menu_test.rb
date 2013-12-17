require './test/test_helper'

class MenuTest < Capybara::Rails::TestCase
  
  def test_guest_can_browse_the_home_page
    visit root_path
    click_on "KFC"
    assert page.has_content?('Kentucky Fried Wonder')
  end

  def test_guest_can_sort_by_specific_category
    visit root_path
    click_on "KFC"
    click_on 'Brunch'

    within ("#main-body") do
      assert_css "#item_#{items(:two).id}"
      assert_content page, "Mashed Potatoes"
    end
    click_on 'Linner'
    within('#main-body') do
      assert_content page, 'Chicken Drumsticks'
      refute_content page, "Mashed Potatoes"
    end
  end

end

