require 'spec_helper'

describe "roots/index.html.erb" do
  before(:each) do
    assign(:roots, [
      stub_model(Root,
        :verb => "Verb",
        :trans => "Trans",
        :kind => "Kind"
      ),
      stub_model(Root,
        :verb => "Verb",
        :trans => "Trans",
        :kind => "Kind"
      )
    ])
  end

  it "renders a list of roots" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Verb".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Trans".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Kind".to_s, :count => 2
  end
end
