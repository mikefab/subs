require 'spec_helper'

describe "roots/show.html.erb" do
  before(:each) do
    @root = assign(:root, stub_model(Root,
      :verb => "Verb",
      :trans => "Trans",
      :kind => "Kind"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Verb/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Trans/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Kind/)
  end
end
