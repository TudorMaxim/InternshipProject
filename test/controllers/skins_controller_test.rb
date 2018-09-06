require 'test_helper'

class SkinsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get skins_index_url
    assert_response :success
  end

end
