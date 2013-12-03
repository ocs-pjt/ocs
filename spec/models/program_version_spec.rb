require 'spec_helper'

describe ProgramVersion do

  let(:program_version) {FactoryGirl.create(:program_version)}

  it "should not be valid if the version format is incorrect" do 
    program_version.version = "a.b.c"
    expect(program_version).to_not be_valid
  end
end
