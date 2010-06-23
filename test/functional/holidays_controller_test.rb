require 'test_helper'

class HolidaysControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => Holiday.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    Holiday.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    Holiday.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to holiday_url(assigns(:holiday))
  end
  
  def test_edit
    get :edit, :id => Holiday.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    Holiday.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Holiday.first
    assert_template 'edit'
  end
  
  def test_update_valid
    Holiday.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Holiday.first
    assert_redirected_to holiday_url(assigns(:holiday))
  end
  
  def test_destroy
    holiday = Holiday.first
    delete :destroy, :id => holiday
    assert_redirected_to holidays_url
    assert !Holiday.exists?(holiday.id)
  end
end
