require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup :skip_login

  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_user
    assert_difference('User.count') do
      post :create, :user => { 
        :name                   => 'test',
        :email                  => 'test@test.com',
        :password               => '12345678',
        :password_confirmation  => '12345678'
      }
    end

    assert_redirected_to users_path
  end

  def test_should_get_edit
    get :edit, :id => users(:user).id
    assert_response :success
  end

  def test_should_update_user
    put :update, :id => users(:user).id, :user => { }
    assert_redirected_to users_path
  end

  def test_should_destroy_user
    assert_difference('User.count', -1) do
      delete :destroy, :id => users(:user).id
    end

    assert_redirected_to users_path
  end
end
