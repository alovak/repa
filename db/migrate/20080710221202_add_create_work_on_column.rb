class AddCreateWorkOnColumn < ActiveRecord::Migration
  def self.up
    add_column :tasks, :create_work_on, :date
  end

  def self.down
    remove_column :tasks, :create_work_on
  end
end
