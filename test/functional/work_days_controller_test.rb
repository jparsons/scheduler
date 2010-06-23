require 'test_helper'

class WorkDaysControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:work_days)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create work_day" do
    assert_difference('WorkDay.count') do
      post :create, :work_day => { }
    end

    assert_redirected_to work_day_path(assigns(:work_day))
  end

  test "should show work_day" do
    get :show, :id => work_days(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => work_days(:one).to_param
    assert_response :success
  end

  test "should update work_day" do
    put :update, :id => work_days(:one).to_param, :work_day => { }
    assert_redirected_to work_day_path(assigns(:work_day))
  end

  test "should destroy work_day" do
    assert_difference('WorkDay.count', -1) do
      delete :destroy, :id => work_days(:one).to_param
    end

    assert_redirected_to work_days_path
  end
end
