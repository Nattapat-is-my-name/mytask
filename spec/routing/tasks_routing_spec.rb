require "rails_helper"

RSpec.describe TasksController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/tasks").to route_to("tasks#index")
    end

    it "routes to #new" do
      expect(get: "/tasks/new").to route_to("tasks#new")
    end


    it "routes to #create" do
      expect(post: "/tasks").to route_to("tasks#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/tasks/1").to route_to("tasks#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/tasks/1").to route_to("tasks#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/tasks/1").to route_to("tasks#destroy", id: "1")
    end
  end
end
