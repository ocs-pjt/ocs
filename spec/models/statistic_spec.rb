require 'spec_helper'

describe Statistic do
  
  before(:each) do
    @stat = FactoryGirl.create(:statistic)
    @use_case = FactoryGirl.create(:use_case, user: @stat.user)
    FactoryGirl.create(:permutation, use_case: @use_case)
    FactoryGirl.create(:permutation, use_case: @use_case)
    FactoryGirl.create(:trace, use_case: @use_case)
    FactoryGirl.create(:regular_expression, use_case: @use_case)
  end

  it "recalculates user stats" do
    Statistic.recalculate_stats
    stats = @stat.reload.stats
    expect(stats['permutations']).to eql "2"
    expect(stats['traces']).to eql "1"
    expect(stats['regular_expressions']).to eql "1"
  end

end
