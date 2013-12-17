require "test_helper"

class LocationTest < ActiveSupport::TestCase
  
  test "it can test if it has restaurants" do
    location = locations(:one)
    assert location.has_restaurants?
    restaurants(:one).update(location: locations(:two))
    refute location.has_restaurants?
  end

  test "it can find the active restaurants for a location" do 
    location = locations(:two)
    assert_equal 2, location.active_restaurants.count
  end

end
