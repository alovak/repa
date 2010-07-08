class Notifier < ActionMailer::Base
  def ticket_change(ticket)
    recipients    [ "#{ticket.owner.name} <#{ticket.owner.email}>",
                    "#{ticket.assignee.name} <#{ticket.assignee.email}>"
    ]
    from          SETTINGS[:email_from]
    subject       "Ticket ##{ticket.id} was changed"
    body          :change => ticket.changes.last(:order => 'created_at'), :ticket => ticket
    content_type  'text/plain'
  end
end
