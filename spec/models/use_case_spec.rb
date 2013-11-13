require 'spec_helper'

describe UseCase do
  before do 
    @use_case = FactoryGirl.create(:use_case_with_tags)
  end

  it "returns a new use case with tags" do
    @user =       FactoryGirl.create(:user)
    @collector =  FactoryGirl.create(:collector)
    @tag =        FactoryGirl.create(:tag)
    
    u = UseCase.new_use_case_with_tags(@user.id, @collector.id, nil, [@tag])
    expect(u.user).to eql @user
    expect(u.collector).to eql @collector
    expect(u.tags.first).to eql @tag
  end

  it "returns an existing use case with its key even if the tags are not in the same order in the table" do 
    @tag1, @tag2 = Tag.first, Tag.last
    u = UseCase.select_use_case_with_tags([@tag2, @tag1]).first
    expect(u.key).to eql @use_case.key
  end
end
