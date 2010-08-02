class TicketObserver < ActiveRecord::Observer
  # def before_save(ticket)
  #   if not ticket.new_record? && ticket.changed?

  #     attributes = {}

  #     (ticket.changed & %w(assignee_id comment state)).each do |attr|
  #       attributes[:"#{attr}_is"] = ticket.send(:"#{attr}")
  #       attributes[:"#{attr}_was"] = ticket.send(:"#{attr}_was")
  #     end

  #     attributes[:ticket_id] = ticket.id
  #     Change.create(attributes)
  #   end
  # end
end
