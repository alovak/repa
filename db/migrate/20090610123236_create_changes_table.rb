class CreateChangesTable < ActiveRecord::Migration
  def self.up
    create_table :changes do |t|
      t.integer :owner_id
      t.integer :ticket_id

      t.boolean :assignee_changed
      t.integer :assignee_was
      t.integer :assignee_is

      t.boolean :state_changed
      t.string  :state_was
      t.string  :state_is

      t.text    :comment

      t.timestamps
    end
  end

  def self.down
    drop_table :changes
  end
end
