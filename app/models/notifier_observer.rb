class NotifierObserver < ActiveRecord::Observer
  observe :ticket

  def after_save(ticket)
    Notifier.deliver_ticket_change(ticket)
  end
end
