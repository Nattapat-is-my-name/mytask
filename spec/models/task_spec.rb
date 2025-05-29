require 'rails_helper'

RSpec.describe Task, type: :model do
  it "is valid with valid attributes" do
    task = Task.new(title: "Test Task", due_time: 1.day.from_now)
    expect(task).to be_valid
  end

  it "requires a title" do
    task = Task.new(due_time: 1.day.from_now)
    expect(task).not_to be_valid
  end

  it "requires a due_time" do
    task = Task.new(title: "Test Task")
    expect(task).not_to be_valid
  end

  it "cannot have a past due_time" do
    task = Task.new(title: "Test Task", due_time: 1.day.ago)
    expect(task).not_to be_valid
  end
end
