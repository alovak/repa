require 'test_helper'

class TasksControllerTest < ActionController::TestCase
  setup :skip_login

  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:tasks)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_task
    assert_difference('Task.count') do
      post :create, :task => { :name => 'test', :description => 'test', :group_id => Group.find(:first).id, :periodicity => {:periodicity => 1}, :start_on => Date.today }
    end

    assert_redirected_to task_path(assigns(:task))
  end

  def test_should_show_task
    get :show, :id => tasks(:task).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => tasks(:task).id
    assert_response :success
  end

  def test_should_update_task
    put :update, :id => tasks(:task).id, :task => { }
    assert_redirected_to task_path(assigns(:task))
  end

  def test_should_destroy_task
    assert_difference('Task.count', -1) do
      delete :destroy, :id => tasks(:task).id
    end

    assert_redirected_to tasks_path
  end
end
