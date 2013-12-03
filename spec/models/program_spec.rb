require 'spec_helper'

describe Program do
  it 'returns a program with its id' do
    @program = FactoryGirl.create(:program)
    expect(Program.try_id(@program.id)).to eql @program.id
  end


  it "returns nil if the program doesn't exist" do 
    expect(Program.try_id(222)).to be_nil
  end
end
