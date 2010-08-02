class Ticket < ActiveRecord::Base
  attr_accessor :event

  belongs_to  :assignee, :class_name => 'User'
  belongs_to  :owner, :class_name => 'User'
  has_many    :changes

  validates_presence_of :description, :title, :assignee, :owner

  validates_presence_of :impact, :rollback_process, :if => "event == 'accept_for_implement'"

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
  aasm_state  :reopened


  aasm_event  :approve do
    transitions :from => :pending, :to => :new
  end

  aasm_event  :implement do
    transitions :from => :new, :to => :assigned
  end

  aasm_event  :cancel do
    transitions :from => :new, :to => :canceled
  end

  aasm_event  :accept_for_implement do
    transitions :from => :assigned, :to => :implementing
    transitions :from => :reopened, :to => :implementing
  end

  aasm_event  :accept_for_test do
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

  aasm_event  :reopen do
    transitions :from => :testing, :to => :assigned
    transitions :from => :closed, :to => :reopened
  end

  before_save :call_event

  def allow_event?(event)
    aasm_events_for_current_state.include?(event.to_sym)
  end

  def changeable_by?(user)
    (original_assignee == user) || (original_assignee.nil?)
  end

  def original_assignee
    if assignee_id_changed?
      assignee_id_was.nil? ? nil : User.find_by_id(assignee_id_was)
    else
      assignee
    end
  end


  def self.close_with_date(id, date)
    date_time = Time.zone.parse(date)
    Ticket.record_timestamps = false
    Change.record_timestamps = false

    ticket = Ticket.find(id)
    ticket.created_at = date_time

    ticket.changes.find(:all, :order => 'id DESC').each do |change|
      date_time = date_time + rand(20).minutes
      change.created_at = change.updated_at = date_time
      change.save!
    end

    ticket.updated_at = date_time
    ticket.save!
  end

  private

  def call_event
    send(:"#{event}") unless event.blank?
  end
end
