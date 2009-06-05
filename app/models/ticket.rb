class Ticket < ActiveRecord::Base
  include AASM
  aasm_column :state

  aasm_initial_state :new

  aasm_state  :new
  aasm_state  :accepted
  aasm_state  :cancelled

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

  aasm_event  :implement do
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
end
