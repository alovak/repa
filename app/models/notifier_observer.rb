class NotifierObserver < ActiveRecord::Observer
  observe :change

  def after_create(change)
    Notifier.deliver_ticket_change(change)
  end
end
