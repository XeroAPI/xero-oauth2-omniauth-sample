require 'test_helper'

class OrganisationControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get organisation_index_url
    assert_response :success
  end

end
