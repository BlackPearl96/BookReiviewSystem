require "test_helper"
class Admin::StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_static_pages_index_url
    assert_response :success
  end
end
