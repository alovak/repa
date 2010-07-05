Feature:
  As a repa user
  I want to create ticket for any job
  In order to meet PCI requirement

  Background:
    Given the following user exists:
      | email             | password | name       |
      | john@example.com  |    12345 | John Doe   |
      | bill@example.com  |    12345 | Bill Gates |
      | steve@example.com |    12345 | Steve Jobs |

  Scenario: create ticket
    When I log in as "john@example.com" with "12345"
    When I follow "Tickets"
    And I follow "Create ticket"
    And I fill in the following:
      | Title       | Job title       |
      | Description | Job description |
      | Comment     | Comment text    |
    And select "approve" from "action"
    And select "Bill Gates" from "who's responsible"
    And press "Create"

    Then I should see "Ticket was successfully created"
    And should see "Job title" within ".ticket .title"
    And should see "Job description" within ".ticket .description"
    And should see "new" within ".ticket .state"
    And should see "Bill Gates" within ".ticket .assignee"


  Scenario: approve the ticket and assign a user to implement job
    Given the following ticket exists:
      | title     | state | assignee         | owner          |
      | Job title | new   | name: Bill Gates | name: John Doe |

    When I log in as "bill@example.com" with "12345"
    And follow "Tickets"
    And follow "Job title"
    And select "implement" from "action"
    And select "Steve Jobs" from "who's responsible"
    And press "Обновить"
    Then I should see "Ticket was successfully updated"
    And should see "Steve Jobs" within ".ticket .info"

  Scenario: approve the ticket and assign a user to implement job
    Given the following ticket exists:
      | title     | state | assignee         | owner          |
      | Job title | new   | name: Bill Gates | name: John Doe |

    When I log in as "bill@example.com" with "12345"
    And follow "Tickets"
    And follow "Job title"
    And select "implement" from "action"
    And select "Steve Jobs" from "who's responsible"
    And press "Обновить"
    Then I should see "Ticket was successfully updated"
    And should see "Steve Jobs" within ".ticket .info"
    And should see "assigned" within ".ticket .state"

  Scenario: start ticket implementation
    Given the following ticket exists:
      | title     | state    | assignee         | owner          |
      | Job title | assigned | name: Steve Jobs | name: John Doe |

    When I log in as "steve@example.com" with "12345"
    And follow "Tickets"
    And follow "Job title"
    And I fill in the following:
      | Impact           | impact description                  |
      | Rollback process | description of the rollback process |
    And select "accept" from "action"
    And press "Обновить"

    Then I should see "impact description" within ".ticket .impact"
    And should see "description of the rollback process" within ".ticket .rollback_process"
