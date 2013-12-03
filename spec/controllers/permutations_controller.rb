require 'spec_helper'

describe PermutationsController do
  before (:each) do
    @user = FactoryGirl.create(:user)
    sign_in @user
  end

  describe "POST collect" do
    describe "with valid params" do
      it "creates a new Permutation" do
        @use_case = FactoryGirl.create(:use_case)
        expect {
          post :collect, {items: [{"data" => "1,2,3", "function" => "sort"}], use_case_key: @use_case.key }, { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
        }.to change(Permutation, :count).by(1)
      end
    end
  end

end