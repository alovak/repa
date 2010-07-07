class Notifier < ActionMailer::Base
  def ticket_change(change)
    recipients    [ "#{change.ticket.owner.name} <#{change.ticket.owner.email}>",
                    "#{change.ticket.assignee.name} <#{change.ticket.assignee.email}>"
    ]
    from          SETTINGS[:email_from]
    subject       "Ticket ##{change.ticket.id} was changed"
    body          :change => change, :ticket => change.ticket
    content_type  'text/plain'
  end
end
