class CreateTickets < ActiveRecord::Migration
  def self.up
    create_table :tickets do |t|
      t.string    :title,
                  :state

      t.text      :description, :implementation,
                  :affected_before, :affected_during, :affected_after,
                  :implementation_risks,
                  :rollback_procedure,
                  :request_alternatives

      t.integer   :onwer_id

      t.timestamps
    end
  end

  def self.down
    drop_table :tickets
  end
end
