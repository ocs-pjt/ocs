require "spec_helper"

describe ApplicationHelper do

  describe "#truncate_popup" do
    it "returns the content of the partial if the data is too long" do
      resource = mock_model Permutation, data: "1,2,3,4,5"
      size = 2

      helper.should_receive(:render).with(any_args)
      helper.truncate_popup(resource, size)
    end

    it "returns the data" do
      resource = mock_model Trace, data: 'MyBeautifulTrace'

      expect(helper.truncate_popup(resource)).to eql resource.data
    end
  end

  describe "#export_button" do 
    it "returns a CSV button" do 
      options = {format: 'csv', resource_type: 'permutation'}

      expect(helper.export_button(options)).to match 'Export CSV'
    end
  end

  describe "#display_filename" do 
    it "returns a link for provided file" do
      file = mock_model "Foo", path: "Traces", url: "/traces"
      expect(helper.display_filename(file)).to eql link_to('Traces', '/traces')
    end
  end
end