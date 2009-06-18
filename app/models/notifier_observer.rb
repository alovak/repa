class NotifierObserver < ActiveRecord::Observer
  observe :change

  def after_save(change)
    Notifier.deliver_ticket_change(change)
  end
end
