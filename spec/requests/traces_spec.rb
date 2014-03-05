require 'spec_helper'

describe "Traces" do
  describe "GET /traces" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      sign_in_as_a_valid_user
      get traces_path
      response.status.should be(200)
    end
  end
end
