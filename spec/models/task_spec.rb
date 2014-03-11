require 'spec_helper'

describe Task do
  before(:each) do
    @task = FactoryGirl.create(:task)
  end

  it "returns the filename" do 
    expect(@task.filename).to eql "fake.txt"
  end

  it "returns the file url" do 
    expect(@task.url).to eql @task.file.url
  end
end
