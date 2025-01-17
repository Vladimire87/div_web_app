require "test_helper"

class HoldingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @holding = holdings(:one)
  end

  test "should get index" do
    get holdings_url
    assert_response :success
  end

  test "should get new" do
    get new_holding_url
    assert_response :success
  end

  test "should create holding" do
    assert_difference("Holding.count") do
      post holdings_url, params: { holding: { portfolio_id: @holding.portfolio_id, shares: @holding.shares, ticker: @holding.ticker } }
    end

    assert_redirected_to holding_url(Holding.last)
  end

  test "should show holding" do
    get holding_url(@holding)
    assert_response :success
  end

  test "should get edit" do
    get edit_holding_url(@holding)
    assert_response :success
  end

  test "should update holding" do
    patch holding_url(@holding), params: { holding: { portfolio_id: @holding.portfolio_id, shares: @holding.shares, ticker: @holding.ticker } }
    assert_redirected_to holding_url(@holding)
  end

  test "should destroy holding" do
    assert_difference("Holding.count", -1) do
      delete holding_url(@holding)
    end

    assert_redirected_to holdings_url
  end
end
