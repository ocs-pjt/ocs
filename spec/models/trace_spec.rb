require 'spec_helper'

describe Trace do
  it "inserts new traces" do
    @use_case = FactoryGirl.create(:use_case)
    @addition_information = FactoryGirl.create(:additional_information)
    items = [['1,2,3'],['4,5,6']]
    expect{ Trace.insert(items, @use_case, @addition_information) }.to change{Trace.count}.by(2)
  end
end
