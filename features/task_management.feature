# features/task_management.feature
Feature: Task Management
    As a user
    I want to manage my tasks
    So that I can stay organized and productive

    Background:
        Given I am on the tasks page

    Scenario: View empty task list
        When I visit the tasks page
        Then I should see "No tasks"
        And I should see a "New Task" link

    Scenario: Create a new task
        Given I click on "New Task"
        When I fill in "Title" with "Complete project documentation"
        And I fill in "Due Date & Time" with tomorrow at 2 PM
        And I click "Create Task"
        Then I should see "Task was successfully created"
        And I should see "Complete project documentation" in the task list
        And I should see the task in the "In Progress" section

    Scenario: Mark a task as completed
        Given I have a task "Review code changes" due tomorrow
        When I check the completion checkbox for "Review code changes"
        Then the task should move to the "Completed" section
        And the task title should be crossed out

    Scenario: Delete a task
        Given I have a task "Old unnecessary task"
        When I click the delete button for "Old unnecessary task"
        And I confirm the deletion
        Then I should not see "Old unnecessary task" in the task list
        And I should see "Task was successfully destroyed"

    Scenario: View task sections
        Given I have the following tasks:
            | title          | status    | due_date |
            | Current task   | progress  | tomorrow |
            | Completed task | completed | today    |
        When I visit the tasks page
        Then I should see "In Progress" section with 1 task
        And I should see "Completed" section with 1 task

    Scenario: Create task with validation errors
        Given I click on "New Task"
        When I fill in "Title" with ""
        And I click "Create Task"
        Then I should see "Title can't be blank"
        And I should see "Due time can't be blank"
        And I should remain on the new task page