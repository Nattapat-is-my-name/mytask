# features/step_definitions/task_steps.rb

# Navigation steps
Given('I am on the tasks page') do
  visit tasks_path
end

When('I visit the tasks page') do
  visit tasks_path
end

Given('I click on {string}') do |button_text|
  click_link_or_button button_text
end

# Task creation steps
When('I fill in {string} with {string}') do |field, value|
  fill_in field, with: value
end

When('I fill in {string} with tomorrow at 2 PM') do |field|
  tomorrow_2pm = 1.day.from_now.change(hour: 14, min: 0)
  formatted_time = tomorrow_2pm.strftime('%Y-%m-%dT%H:%M')
  fill_in field, with: formatted_time
end

When('I try to set due date to yesterday') do
  yesterday = 1.day.ago.strftime('%Y-%m-%dT%H:%M')
  fill_in 'Due Date & Time', with: yesterday
end

When('I click {string}') do |button_text|
  click_button button_text
end

# Task interaction steps
When('I check the completion checkbox for {string}') do |task_title|
  task_element = find('article', text: task_title)
  within(task_element) do
    check('task[completed]')
  end
end

When('I click the delete button for {string}') do |task_title|
  task_element = find('article', text: task_title)
  within(task_element) do
    click_link 'Delete'
  end
end

When('I confirm the deletion') do
  # Assuming you have a confirmation dialog
  click_button 'Delete' if page.has_button?('Delete')
end

# Verification steps
Then('I should see {string}') do |text|
  expect(page).to have_content(text)
end

Then('I should see a {string} button') do |button_text|
  expect(page).to have_link_or_button(button_text)
end

Then('I should see {string} in the task list') do |task_title|
  expect(page).to have_content(task_title)
end

Then('I should see the task in the {string} section') do |section_name|
  section = find('h2', text: section_name, match: :first).ancestor('div', match: :first)
  expect(section).to have_content('Complete project documentation')
end

Then('the task should move to the {string} section') do |section_name|
  section = find('h2', text: section_name, match: :first).ancestor('div', match: :first)
  expect(section).to have_content('Review code changes')
end

Then('the task title should be crossed out') do
  expect(page).to have_css('.line-through')
end

Then('I should not see {string} in the task list') do |task_title|
  expect(page).not_to have_content(task_title)
end

Then('the task should be highlighted in red') do
  expect(page).to have_css('.bg-red-50')
end

Then('I should see {string} in the {string} section') do |task_title, section_name|
  section = find('h2', text: section_name, match: :first).ancestor('div', match: :first)
  within(section) do
    expect(page).to have_content(task_title)
  end
end

Then('I should see {string} section with {int} task(s)') do |section_name, count|
  section = find('h2', text: section_name, match: :first).ancestor('div', match: :first)
  tasks = section.all('article')
  expect(tasks.count).to eq(count)
end

Then('I should remain on the new task page') do
  expect(page).to have_content('New Task')
  expect(current_path).to eq(new_task_path)
end

# Setup steps for test data
Given('I have a task {string} due tomorrow') do |task_title|
  Task.create!(
    title: task_title,
    due_time: 1.day.from_now,
    completed: false
  )
  visit tasks_path
end

Given('I have a task {string}') do |task_title|
  Task.create!(
    title: task_title,
    due_time: 1.day.from_now,
    completed: false
  )
  visit tasks_path
end

Given('I have the following tasks:') do |table|
  table.hashes.each do |task_data|
    due_date = case task_data['due_date']
    when 'yesterday'
                 1.day.ago
    when 'tomorrow'
                 1.day.from_now
    else
                 1.day.from_now
    end

    completed = task_data['status'] == 'completed'

    Task.create!(
      title: task_data['title'],
      due_time: due_date,
      completed: completed
    )
  end
  visit tasks_path
end

# Helper method to handle both links and buttons
def click_link_or_button(locator)
  if page.has_link?(locator)
    click_link(locator)
  elsif page.has_button?(locator)
    click_button(locator)
  else
    raise "Could not find link or button with text '#{locator}'"
  end
end

Then('I should see {string} information') do |text|
  expect(page).to have_content(text)
end

Then('I should see a {string} link') do |link_text|
  expect(page).to have_link(link_text)
end

def have_link_or_button(locator)
  have_link(locator).or(have_button(locator))
end
