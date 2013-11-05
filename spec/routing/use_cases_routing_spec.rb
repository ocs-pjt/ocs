require "spec_helper"

describe UseCasesController do
  describe "routing" do

    it "routes to #index" do
      get("/use_cases").should route_to("use_cases#index")
    end

    it "routes to #new" do
      get("/use_cases/new").should route_to("use_cases#new")
    end

    it "routes to #show" do
      get("/use_cases/1").should route_to("use_cases#show", :id => "1")
    end

    it "routes to #edit" do
      get("/use_cases/1/edit").should route_to("use_cases#edit", :id => "1")
    end

    it "routes to #create" do
      post("/use_cases").should route_to("use_cases#create")
    end

    it "routes to #update" do
      put("/use_cases/1").should route_to("use_cases#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/use_cases/1").should route_to("use_cases#destroy", :id => "1")
    end

  end
end
