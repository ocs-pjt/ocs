require 'spec_helper'

describe Permutation do
  it "inserts new permutations" do
    @use_case = FactoryGirl.create(:use_case)
    items = [{ 'data' => '1,2,3', 'function' => 'sort' },{ 'data' => '4,5,6', 'function' => 'sort' }]
    expect{ Permutation.insert(items, @use_case) }.to change{Permutation.count}.by(2)
  end
end
