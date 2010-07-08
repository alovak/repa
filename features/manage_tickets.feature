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
    And should see "John Doe" within ".ticket .owner"
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
    And press "Update"
    Then I should see "Ticket was successfully updated"
    And should see "assigned" within ".ticket .state"
    And should see "Steve Jobs" within ".ticket .assignee"

    And should see "new" within ".change .state_was"
    And should see "assigned" within ".change .state_is"
    And should see "Bill Gates" within ".change .assignee_was"
    And should see "Steve Jobs" within ".change .assignee_is"


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
    And press "Update"

    Then I should see "Ticket was successfully updated"
    And should see "impact description" within ".ticket .impact"
    And should see "description of the rollback process" within ".ticket .rollback_process"

    And should see "implementing" within ".ticket .state"
    And should see "Steve Jobs" within ".ticket .assignee"

    And should see "assigned" within ".change .state_was"
    And should see "implementing" within ".change .state_is"
