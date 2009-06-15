class Ticket < ActiveRecord::Base
  belongs_to  :assignee, :class_name => 'User'
  belongs_to  :owner, :class_name => 'User'
  has_many    :changes

  include AASM
  aasm_column :state

  aasm_initial_state :pending

  aasm_state  :pending
  aasm_state  :new
  aasm_state  :assigned
  aasm_state  :canceled
  aasm_state  :implementing
  aasm_state  :implemented
  aasm_state  :test
  aasm_state  :testing
  aasm_state  :closed

  aasm_event  :leave do
    transitions :from => :pending, :to => :pending
    transitions :from => :new, :to => :new
    transitions :from => :assigned, :to => :assigned
    transitions :from => :implementing, :to => :implementing
    transitions :from => :implemented, :to => :implemented
    transitions :from => :test, :to => :test
    transitions :from => :testing, :to => :testing
  end

  aasm_event  :approve do
    transitions :from => :pending, :to => :new
  end

  aasm_event  :assign do
    transitions :from => :new, :to => :assigned
  end

  aasm_event  :cancel do
    transitions :from => :new, :to => :canceled
  end

  aasm_event  :accept do
    transitions :from => :assigned, :to => :implementing
    transitions :from => :implemented, :to => :testing
  end

  aasm_event  :test do
    transitions :from => :implementing, :to => :implemented
  end

  aasm_event  :testing do
    transitions :from => :test, :to => :testing
  end

  aasm_event  :close do
    transitions :from => :testing, :to => :closed
  end

  def allow_event?(event)
    aasm_events_for_current_state.include?(event.to_sym)
  end
end
