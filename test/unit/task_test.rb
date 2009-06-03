require 'test_helper'

class TaskTest < ActiveSupport::TestCase

  def test_should_create_valid_task
    assert @task.valid?, 'Invalid fixture task'
    assert create_task.valid?, 'Invalid manually created task'
  end

  def test_periodicity_validation
    @task.periodicity = {:periodicity => 31}
    assert @task.valid?

    @task.periodicity = {:periodicity => 0}
    assert !@task.valid?
  end

  def test_work_on_must_be_equal_to_start_on_on_create
    t = create_task
    assert_equal t.start_on, t.create_work_on
  end

  def test_work_on_should_change_when_start_on_updated
    t = create_task
    t.start_on = Date.tomorrow
    assert_not_equal t.start_on, t.create_work_on
    t.save
    assert_equal t.start_on, t.create_work_on
  end

  def test_should_find_tasks_to_create_works_only_for_present_and_past_time
    Task.delete_all
    
    create_task(:start_on => Date.tomorrow)
    assert_equal 0, Task.find_tasks_for_works.size
    
    actual_tasks_count = 3
    actual_tasks_count.times {|counter| create_task( :name => "Task + #{ counter }")}
    
    assert_equal actual_tasks_count, Task.find_tasks_for_works.size

    create_task(:start_on => Date.tomorrow)
    assert_equal actual_tasks_count, Task.find_tasks_for_works.size

    create_task(:start_on => Date.yesterday)
    assert_equal actual_tasks_count + 1, Task.find_tasks_for_works.size
  end

  def test_should_create_work_for_task
    create_work_on = @task.create_work_on
    work = @task.create_work
    assert work.valid?
    assert_equal create_work_on, work.created_at.to_date 
  end

  def test_should_delete_task_works_on_dask_deleting
    work = @task.create_work
    @task.destroy
    assert !Work.find_by_id(work.id)
  end

  def test_created_work_group_should_be_equal_to_task_group
    assert_equal @task.group, @task.create_work.group
  end

  def test_task_should_change_create_work_on_after_create_work
    @task.create_work
    assert_equal @task.create_work_on , @task.start_on + @task.periodicity.periodicity
  end

  def test_should_create_works_for_missed_period
    Work.delete_all
    Task.delete_all
    missed_periods = created_works_count = 3

    task = create_task 
    task.start_on = Date.today - task.periodicity.periodicity*missed_periods + 1
    task.save
    
    assert_equal created_works_count, Task.create_missed_works
  end


  protected
  def create_task(options = {})
    Task.create!({
      :name         => 'Task',
      :description  => 'Description',
      :group        => groups(:users),
      :periodicity  => {:periodicity => 1},
      :start_on     => Date.today 
    }.merge(options))
  end

end
