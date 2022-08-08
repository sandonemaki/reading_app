require 'test_helper'

class PageimagesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get pageimages_show_url
    assert_response :success
  end

end
