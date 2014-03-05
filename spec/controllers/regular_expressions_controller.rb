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

  describe "POST collect" do
    describe "with valid params" do
      it "creates a new RegularExpression" do
        @use_case = FactoryGirl.create(:use_case)
        expect {
          post :collect, {items: [{"data" => "1,2,3", "function" => "sort"}], use_case_key: @use_case.key }, { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
        }.to change(RegularExpression, :count).by(1)
      end
    end
  end

end