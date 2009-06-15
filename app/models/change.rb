class Change < ActiveRecord::Base
  belongs_to :owner, :class_name => 'User'
  default_scope :order => 'created_at DESC'

  def set_assignees(ticket)
    self.assignee_changed = true
    self.assignee_was = ticket.assignee_id_was
    self.assignee_is = ticket.assignee_id
  end

  def set_state(ticket)
    self.state_changed = true
    self.state_was = ticket.state_was
    self.state_is = ticket.state
  end
end
