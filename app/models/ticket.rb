class Ticket < ActiveRecord::Base
  belongs_to :assignee, :class_name => 'User'

  include AASM
  aasm_column :state

  aasm_initial_state :new

  aasm_state  :new
  aasm_state  :accepted
  aasm_state  :cancelled
  aasm_state  :approved
  aasm_state  :implementing
  aasm_state  :implemented
  aasm_state  :reopened
  aasm_state  :testing
  aasm_state  :closed

  aasm_event  :cancel do
    transitions :from => [:new, :approved, :implementing, :implemented, :reopened, :testing],
                :to => :cancelled
  end

  aasm_event  :approve do
    transitions :from => :new, :to => :approved
  end

  aasm_event  :accept do
    transitions :from => [:approved, :reopened], :to => :implementing
  end

  aasm_event  :finish do
    transitions :from => [:implementing, :reopened, :approved], :to => :implemented
  end

  aasm_event  :test do
    transitions :from => :implemented, :to => :testing
  end

  aasm_event  :close do
    transitions :from => :testing , :to => :closed
  end

  aasm_event  :reopen do
    transitions :from => :testing , :to => :reopened
  end

  def allow_event?(event)
    aasm_events_for_current_state.include?(event.to_sym)
  end
end
