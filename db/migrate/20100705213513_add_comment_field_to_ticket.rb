class AddCommentFieldToTicket < ActiveRecord::Migration
  def self.up
    add_column :tickets, :comment, :text
  end

  def self.down
    remove_column :tickets, :comment
  end
end
