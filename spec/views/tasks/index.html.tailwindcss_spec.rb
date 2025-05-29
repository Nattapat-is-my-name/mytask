require 'rails_helper'

RSpec.describe "tasks/index", type: :view do
  before(:each) do
    assign(:tasks, [
      Task.create!(
        title: "Title",
        status: "Status"
      ),
      Task.create!(
        title: "Title",
        status: "Status"
      )
    ])
  end

  # it "renders a list of tasks" do
  #   render
  #   cell_selector = 'div>p'
  #   assert_select cell_selector, text: Regexp.new("Title".to_s), count: 2
  #   assert_select cell_selector, text: Regexp.new("Status".to_s), count: 2
  # end
end
