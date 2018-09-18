require 'test_helper'

class BoughtSkinsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get bought_skins_index_url
    assert_response :success
  end

end
