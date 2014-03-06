require 'spec_helper'

describe ResourcesController do
  before (:each) do
    sign_in
  end

  describe "POST permutation collect" do
    describe "with valid params" do
      it "creates a new permutation" do
        @use_case = FactoryGirl.create(:use_case)
        expect {
          post :collect, {object: {data: ['1,2,3'], data_type: 'permutation'}, use_case_key: @use_case.key }, { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
        }.to change(Permutation, :count).by(1)
      end
    end
  end

  describe "POST trace collect" do
    describe "with valid params" do
      it "creates a new trace" do
        @use_case = FactoryGirl.create(:use_case)
        expect {
          post :collect, {object: {data: ['1,2,3','4,5,6'], data_type: 'trace'}, use_case_key: @use_case.key }, { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
        }.to change(Trace, :count).by(2)
      end
    end
  end

  describe "POST regular expression collect" do
    describe "with valid params" do
      it "creates a new regular expression" do
        @use_case = FactoryGirl.create(:use_case)
        expect {
          post :collect, {object: {data: ['1,2,3'], data_type: 'regular_expression'}, use_case_key: @use_case.key }, { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
        }.to change(RegularExpression, :count).by(1)
      end
    end
  end

end

