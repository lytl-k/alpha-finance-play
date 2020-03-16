require 'test_helper'

class TechnicalIndicatorsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get technical_indicators_index_url
    assert_response :success
  end

end
