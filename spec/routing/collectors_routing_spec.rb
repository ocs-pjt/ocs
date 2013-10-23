require "spec_helper"

describe CollectorsController do
  describe "routing" do

    it "routes to #index" do
      get("/collectors").should route_to("collectors#index")
    end

    it "routes to #new" do
      get("/collectors/new").should route_to("collectors#new")
    end

    it "routes to #show" do
      get("/collectors/1").should route_to("collectors#show", :id => "1")
    end

    it "routes to #edit" do
      get("/collectors/1/edit").should route_to("collectors#edit", :id => "1")
    end

    it "routes to #create" do
      post("/collectors").should route_to("collectors#create")
    end

    it "routes to #update" do
      put("/collectors/1").should route_to("collectors#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/collectors/1").should route_to("collectors#destroy", :id => "1")
    end

  end
end
