require 'test_helper'

class GroupsControllerTest < ActionController::TestCase
  def setup
    skip_login
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:groups)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_group
    assert_difference('Group.count') do
      post :create, :group => { :name => 'test' }
    end

    assert_redirected_to groups_path
  end

  def test_should_get_edit
    get :edit, :id => groups(:users).id
    assert_response :success
  end

  def test_should_destroy_group
    assert_difference('Group.count', -1) do
      delete :destroy, :id => groups(:users).id
    end

    assert_redirected_to groups_path
  end
end
