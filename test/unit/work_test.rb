require 'test_helper'

class WorkTest < ActiveSupport::TestCase
  def test_truth
    assert true
  end

  def test_should_create_valid_work
    assert @work.valid?, 'Invalid fixture work'

    work = Work.create(:task_id => @task.id, :owner_id => @user.id, :status => { :status => 1 })
    assert work.valid?, 'Can\'t create work with fixtures data'
  end

  def test_allowed_statuses
    Status::OPTIONS.each do |status|
      @work.status = { :status => status[1] }
      assert_equal @work.status.name, status[0]
    end
  end

  def test_status_validation
    @work.status = 'something'
    assert_error_on(@work, :status, :invalid)
    assert_error_on(@work.status, :status, :inclusion)
  end

  def test_delete_owner_if_status_changed_to_new
    #TODO Change status hash {:status => 1} to Status.statuses('new') or something like this...
    @work.status = {:status => 2}
    @work.owner = @user
    @work.save!
    assert_not_nil @work.owner

    @work.status = {:status => 1}
    @work.save!
    assert_nil @work.owner
  end

  def test_should_automatically_close_new_works_by_first_user
    @work.created_at = @work.updated_at = Date.yesterday
    @work.auto_close( @user.id )
    assert_equal 3, @work.status.status
    assert_equal @user.id, @work.owner.id
    assert @work.updated_at < @work.created_at + @work.task.periodicity.periodicity.days
  end
end
