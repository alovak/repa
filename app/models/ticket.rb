class Ticket < ActiveRecord::Base
  belongs_to  :assignee, :class_name => 'User'
  belongs_to  :owner, :class_name => 'User'
  has_many    :changes

  default_scope :order => 'updated_at DESC'

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
  aasm_state  :need_plan
  aasm_state  :planing
  aasm_state  :planned
  aasm_state  :reopened

  aasm_event  :write_plan do
    transitions :from => :new, :to => :need_plan
    transitions :from => :planned, :to => :need_plan
  end

  aasm_event  :check_plan do
    transitions :from => :planing, :to => :planned
  end

  aasm_event  :approve do
    transitions :from => :pending, :to => :new
  end

  aasm_event  :implement do
    transitions :from => :new, :to => :assigned
    transitions :from => :planned, :to => :assigned
  end

  aasm_event  :cancel do
    transitions :from => :new, :to => :canceled
  end

  aasm_event  :accept do
    transitions :from => :assigned, :to => :implementing
    transitions :from => :reopened, :to => :implementing
    transitions :from => :implemented, :to => :testing
    transitions :from => :need_plan, :to => :planing
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

  aasm_event  :reopen do
    transitions :from => :closed, :to => :reopened
  end

  def allow_event?(event)
    aasm_events_for_current_state.include?(event.to_sym)
  end
end
