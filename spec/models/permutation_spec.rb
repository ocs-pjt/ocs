require 'spec_helper'

describe Permutation do
  it "inserts new permutations" do
    @use_case = FactoryGirl.create(:use_case)
    @addition_information = FactoryGirl.create(:additional_information)
    items = [['1,2,3'],['4,5,6']]
    expect{ Permutation.insert(items, @use_case, @addition_information) }.to change{Permutation.count}.by(2)
  end
end
