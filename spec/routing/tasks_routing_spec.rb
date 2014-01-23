require "spec_helper"

describe TasksController do
  describe "routing" do

    it "routes to #index" do
      get("/tasks").should route_to("tasks#index")
    end

    it "routes to #destroy" do
      delete("/tasks/1").should route_to("tasks#destroy", :id => "1")
    end

  end
end
