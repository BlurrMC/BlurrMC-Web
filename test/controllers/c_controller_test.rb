require 'test_helper'

class CControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get c_show_url
    assert_response :success
  end

end
