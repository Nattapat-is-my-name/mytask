# features/step_definitions/workflow_steps.rb

# Task ordering and priority steps
Given('I have the following tasks with specific due times:') do |table|
  table.hashes.each do |task_data|
    due_time = case task_data['due_time']
    when '1 hour from now'
                 1.hour.from_now
    when '1 day from now'
                 1.day.from_now
    when '1 week from now'
                 1.week.from_now
    else
                 1.day.from_now
    end

    Task.create!(
      title: task_data['title'],
      due_time: due_time,
      completed: false
    )
  end
  visit root_path
end

Then('{string} should appear before {string}') do |first_task, second_task|
  first_position = page.body.index(first_task)
  second_position = page.body.index(second_task)
  expect(first_position).to be < second_position
end

# Badge verification steps
Then('I should see {string} badge for {string}') do |badge_text, task_title|
  task_element = find('article', text: task_title)
  within(task_element) do
    expect(page).to have_content(badge_text)
  end
end

# Responsive testing steps
When('I resize the browser to mobile size') do
  page.driver.browser.manage.window.resize_to(375, 667) # iPhone size
end

Then('I should still be able to see the task') do
  expect(page).to have_content('Mobile responsive task')
end

Then('I should still be able to mark it as complete') do
  expect(page).to have_css('input[type="checkbox"]')
end

Then('I should still be able to delete it') do
  expect(page).to have_content('Delete')
end

# Form validation steps
Then('I should see validation errors') do
  expect(page).to have_css('.bg-red-50') # Error container
end

Then('the form fields should be highlighted in red') do
  expect(page).to have_css('.border-red-300')
end

Then('I should see helpful error messages') do
  expect(page).to have_content("can't be blank")
end

# Dynamic updates (JavaScript)
Then('the page should update without full reload') do
  # This checks that we're still on the same page without redirect
  expect(page).to have_current_path(root_path)
end

Then('the task should move to completed section smoothly') do
  within('#completed-tasks') do
    expect(page).to have_content('Dynamic task')
  end
end

# Navigation flow steps
When('I fill in the task form with valid data') do
  fill_in 'Title', with: 'Test Navigation Task'
  tomorrow = 1.day.from_now.strftime('%Y-%m-%dT%H:%M')
  fill_in 'Due Date & Time', with: tomorrow
end

Then('I should be redirected to the tasks page') do
  expect(page).to have_current_path(root_path)
end

Then('I should see the newly created task') do
  expect(page).to have_content('Test Navigation Task')
end

When('I click {string} on the new task form') do |button_text|
  click_link button_text
end

Then('I should be redirected to the tasks page') do
  expect(page).to have_current_path(root_path)
end

Then('Without creating any task') do
  expect(Task.count).to eq(0)
end

# Time formatting steps
Given('I have a task {string} due {string}') do |task_title, due_time_string|
  due_time = case due_time_string
  when '2 days ago'
               2.days.ago
  when /^\d{4}-\d{2}-\d{2} \d{2}:\d{2}$/
               DateTime.parse(due_time_string)
  else
               1.day.from_now
  end

  Task.create!(
    title: task_title,
    due_time: due_time,
    completed: false
  )
  visit root_path
end

# Hook for cleaning up browser size after responsive tests
After('@responsive') do
  page.driver.browser.manage.window.resize_to(1400, 1000) # Reset to default
end
