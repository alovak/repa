class CreateTasks < ActiveRecord::Migration
  def self.up
    create_table :tasks do |t|
      t.string :name
      t.text :description
      t.integer :group_id
      t.integer :periodicity
      t.date :start_on
      
      t.timestamps
    end
  end

  def self.down
    drop_table :tasks
  end
end
