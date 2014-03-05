require 'spec_helper'

describe RegularExpression do
  it "inserts new regular expressions" do
    @use_case = FactoryGirl.create(:use_case)
    @addition_information = FactoryGirl.create(:additional_information)
    items = [['1,2,3'],['4,5,6']]
    expect{ RegularExpression.insert(items, @use_case, @addition_information) }.to change{RegularExpression.count}.by(2)
  end
end
