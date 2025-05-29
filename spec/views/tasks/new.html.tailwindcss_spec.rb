require 'rails_helper'

RSpec.describe "tasks/new", type: :view do
  before(:each) do
    assign(:task, Task.new(
      title: "MyString",
      due_time: 1.day.from_now
    ))
  end

  it "renders new task form" do
    render

    assert_select "form[action=?][method=?]", tasks_path, "post" do
      assert_select "input[name=?]", "task[title]"
      assert_select "input[name=?]", "task[due_time]"
    end
  end
end
