require 'spec_helper'

describe RegularExpressionsController do
  before (:each) do
    sign_in
  end

  describe "GET index" do 
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end
end