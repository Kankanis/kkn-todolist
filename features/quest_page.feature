Feature: Quest Management

  As a user
  I want to manage my quests
  So that I can track my tasks and achievements

  Background:
    Given there are no quests
    And I am on the quests index page

  Scenario: Viewing the quest list when there are no quests
    Then I should see "Quests" as the page title
    And I should see "No quests found."
    And I should see "Add a new quest to get started!"
    And I should see an input field with placeholder "Add new quest.."
    And I should see the "plus" button

  @javascript
  Scenario: Navigating to Brag Page and back
    When I click "My Brag"
    Then I should be on the brag page
    When I click the "back to quests" button
    Then I should be on the quests index page
    And I should see "Quests" as the page title

  Scenario: Viewing the quest list when there are existing quests
    Given there is a quest named "Learn Ruby"
    And there is a quest named "Practice Rails"
    And I am on the quests index page 
    Then I should see "Quests" as the page title
    And I should not see "No quests found."
    And I should see "Learn Ruby"
    And I should see "Practice Rails"
    