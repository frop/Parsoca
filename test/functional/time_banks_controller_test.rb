require 'test_helper'

class TimeBanksControllerTest < ActionController::TestCase
  setup do
    @time_bank = time_banks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:time_banks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create time_bank" do
    assert_difference('TimeBank.count') do
      post :create, time_bank: @time_bank.attributes
    end

    assert_redirected_to time_bank_path(assigns(:time_bank))
  end

  test "should show time_bank" do
    get :show, id: @time_bank
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @time_bank
    assert_response :success
  end

  test "should update time_bank" do
    put :update, id: @time_bank, time_bank: @time_bank.attributes
    assert_redirected_to time_bank_path(assigns(:time_bank))
  end

  test "should destroy time_bank" do
    assert_difference('TimeBank.count', -1) do
      delete :destroy, id: @time_bank
    end

    assert_redirected_to time_banks_path
  end
end
