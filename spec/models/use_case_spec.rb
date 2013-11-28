require 'spec_helper'

describe UseCase do
  before do 
    @use_case = FactoryGirl.create(:use_case_with_tags)
  end

  it "returns a new use case key" do
    @user = FactoryGirl.create(:user)
    @collector_version =  FactoryGirl.create(:collector_version)
    @tag = FactoryGirl.create(:tag)
    
    key = UseCase.get_new_key(@user.id, @collector_version.id, nil, [@tag])
    expect(key).not_to be_empty
  end

  it "returns an existing use case with its key even if the tags are not in the same order in the table" do 
    @tag1, @tag2 = Tag.first, Tag.last
    u = UseCase.select_use_case_with_tags([@tag2, @tag1]).first
    expect(u.key).to eql @use_case.key
  end
end
