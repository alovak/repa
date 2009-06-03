require 'test_helper'

class WorksControllerTest < ActionController::TestCase
  setup :skip_login

  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:works)
  end

  def test_should_show_work
    get :show, :id => works(:work).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => works(:work).id
    assert_response :success
  end

  def test_should_update_work
    put :update, :id => works(:work).id, :work => { }
    assert_redirected_to edit_work_path(assigns(:work))
  end

  def test_should_destroy_work
    assert_difference('Work.count', -1) do
      delete :destroy, :id => works(:work).id
    end

    assert_redirected_to works_path
  end
end
