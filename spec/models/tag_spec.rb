require 'spec_helper'

describe Tag do
  it 'returns an array of tags' do 
    ar = Tag.find_or_create_tags(['Math', 'Bio'])
    expect(ar).to eql [Tag.first, Tag.last]
  end

  it 'returns nil if tag_names is nil' do 
    expect(Tag.find_or_create_tags(nil)).to be_nil
  end

  it 'returns an array of strip tag names' do 
    ar = Tag.tag_names_from_str('  Bio,   Math  ')
    expect(ar).to eql ['Bio', 'Math']
  end
end
