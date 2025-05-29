require 'rails_helper'

RSpec.describe "tasks/index", type: :view do
  context "with tasks in different states" do
    before(:each) do
      # Travel back in time to create an "overdue" task
      travel_to 2.days.ago do
        @overdue_task = Task.create!(
          title: "Overdue Task",
          status: "Status",
          due_time: 1.day.from_now, # This will be 1 day ago from current time
          completed: false
        )
      end

      # Create current tasks normally
      in_progress_task = Task.create!(
        title: "In Progress Task",
        status: "Status",
        due_time: 1.day.from_now,
        completed: false
      )

      completed_task = Task.create!(
        title: "Completed Task",
        status: "Status",
        due_time: 1.day.from_now,
        completed: true
      )

      assign(:tasks, [ @overdue_task, in_progress_task, completed_task ])
    end

    it "renders tasks in correct sections" do
      render

      expect(rendered).to include("Overdue Tasks")
      expect(rendered).to include("In Progress")
      expect(rendered).to include("Completed")
      expect(rendered).to include("Overdue Task")
      expect(rendered).to include("In Progress Task")
      expect(rendered).to include("Completed Task")
    end
  end
end
