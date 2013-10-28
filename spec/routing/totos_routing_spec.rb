require "spec_helper"

describe TotosController do
  describe "routing" do

    it "routes to #index" do
      get("/totos").should route_to("totos#index")
    end

    it "routes to #new" do
      get("/totos/new").should route_to("totos#new")
    end

    it "routes to #show" do
      get("/totos/1").should route_to("totos#show", :id => "1")
    end

    it "routes to #edit" do
      get("/totos/1/edit").should route_to("totos#edit", :id => "1")
    end

    it "routes to #create" do
      post("/totos").should route_to("totos#create")
    end

    it "routes to #update" do
      put("/totos/1").should route_to("totos#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/totos/1").should route_to("totos#destroy", :id => "1")
    end

  end
end
