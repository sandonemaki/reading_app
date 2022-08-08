require 'test_helper'

class VoicetextsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get voicetexts_new_url
    assert_response :success
  end

end
