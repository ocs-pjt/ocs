require "spec_helper"

describe UseCasesController do
  describe "routing" do

    it "routes to #index" do
      get("/use_cases").should route_to("use_cases#index")
    end

  end
end
