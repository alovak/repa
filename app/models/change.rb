class Change < ActiveRecord::Base
  def self.build(ticket)
    Change.new do |change|
      change.set_assignees(ticket) if ticket.assignee_id_changed?
    end
  end

  def set_assignees(ticket)
    self.assignee_changed = true
    self.assignee_was = ticket.assignee_id_was
    self.assignee_is = ticket.assignee_id
  end
end
