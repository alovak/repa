class RenameChangesAttributes < ActiveRecord::Migration
  def self.up
    rename_column :changes, :assignee_was_id, :assignee_id_was
    rename_column :changes, :assignee_is_id, :assignee_id_is
    rename_column :changes, :comment, :comment_is

    add_column :changes, :comment_was, :text
  end

  def self.down
  end
end
