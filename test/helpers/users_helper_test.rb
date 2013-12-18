require "test_helper"

class UsersHelperTest < ActionView::TestCase

  test "it knows about the current user" do
    skip
    session = {}
    session[:user_id] = users(:one).id
    assert_equal users(:one), current_user
  end

end
