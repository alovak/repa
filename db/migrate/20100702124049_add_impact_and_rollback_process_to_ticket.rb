class AddImpactAndRollbackProcessToTicket < ActiveRecord::Migration
  def self.up
    add_column :tickets, :impact, :text
    add_column :tickets, :rollback_process, :text
  end

  def self.down
    remove_columns :tickets, :impact, :rollback_process
  end
end
