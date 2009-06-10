class CreateChangesTable < ActiveRecord::Migration
  def self.up
    create_table :changes do |t|
      t.boolean :assignee_changed
      t.integer :assignee_was
      t.integer :assignee_is

      t.boolean :state_changed
      t.integer :state_was
      t.integer :state_is

      t.text    :comment

      t.timestamps
    end
  end

  def self.down
    drop_table :changes
  end
end
