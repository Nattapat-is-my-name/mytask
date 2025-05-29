require 'rails_helper'

RSpec.describe "/tasks", type: :request do
  # Valid attributes for creating a task (removed status field)
  let(:valid_attributes) {
    {
      title: "Test Task",
      due_time: 1.day.from_now,
      completed: false
    }
  }

  # Invalid attributes that will fail validation
  let(:invalid_attributes) {
    {
      title: "",  # Invalid because title is required
      due_time: nil,  # Invalid because due_time is required
      completed: false
    }
  }

  describe "GET /index" do
    it "renders a successful response" do
      Task.create! valid_attributes
      get tasks_url
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_task_url
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Task" do
        expect {
          post tasks_url, params: { task: valid_attributes }
        }.to change(Task, :count).by(1)
      end

      it "redirects to the tasks index" do
        post tasks_url, params: { task: valid_attributes }
        expect(response).to redirect_to(tasks_url)
      end
    end

    context "with invalid parameters" do
      it "does not create a new Task" do
        expect {
          post tasks_url, params: { task: invalid_attributes }
        }.to change(Task, :count).by(0)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post tasks_url, params: { task: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        {
          title: "Updated Task Title",
          completed: true
        }
      }

      it "updates the requested task" do
        task = Task.create! valid_attributes
        patch task_url(task), params: { task: new_attributes }
        task.reload
        expect(task.title).to eq("Updated Task Title")
        expect(task.completed).to be true
      end

      it "redirects to the tasks index" do
        task = Task.create! valid_attributes
        patch task_url(task), params: { task: new_attributes }
        task.reload
        expect(response).to redirect_to(tasks_url)
      end
    end

    context "with invalid parameters" do
      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        task = Task.create! valid_attributes
        patch task_url(task), params: { task: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested task" do
      task = Task.create! valid_attributes
      expect {
        delete task_url(task)
      }.to change(Task, :count).by(-1)
    end

    it "redirects to the tasks list" do
      task = Task.create! valid_attributes
      delete task_url(task)
      expect(response).to redirect_to(tasks_url)
    end
  end
end
