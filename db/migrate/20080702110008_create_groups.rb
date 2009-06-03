class CreateGroups < ActiveRecord::Migration
  def self.up
    create_table :groups do |t|
      t.string :name

      t.timestamps
    end

    Group.create!(:name => 'Administrators')
  end

  def self.down
    drop_table :groups
  end
end
