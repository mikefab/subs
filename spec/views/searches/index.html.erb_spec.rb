require 'spec_helper'

describe "searches/index.html.erb" do
  before(:each) do
    assign(:searches, [
      stub_model(Search,
        :search => "Search",
        :user_id => 1,
        :lang => "Lang",
        :category => "Category",
        :page => 1,
        :option => false
      ),
      stub_model(Search,
        :search => "Search",
        :user_id => 1,
        :lang => "Lang",
        :category => "Category",
        :page => 1,
        :option => false
      )
    ])
  end

  it "renders a list of searches" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Search".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Lang".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Category".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
