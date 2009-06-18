class Change < ActiveRecord::Base
  belongs_to :owner, :class_name => 'User'
  belongs_to :assignee_is, :class_name => 'User'
  belongs_to :assignee_was, :class_name => 'User'
  belongs_to :ticket

  default_scope :order => 'created_at DESC'

  def set_assignees(ticket)
    self.assignee_changed = true
    self.assignee_was_id = ticket.assignee_id_was
    self.assignee_is_id = ticket.assignee_id
  end

  def set_state(ticket)
    self.state_changed = true
    self.state_was = ticket.state_was
    self.state_is = ticket.state
  end
end
