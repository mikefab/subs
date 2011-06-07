require 'spec_helper'

describe "roots/edit.html.erb" do
  before(:each) do
    @root = assign(:root, stub_model(Root,
      :verb => "MyString",
      :trans => "MyString",
      :kind => "MyString"
    ))
  end

  it "renders the edit root form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => roots_path(@root), :method => "post" do
      assert_select "input#root_verb", :name => "root[verb]"
      assert_select "input#root_trans", :name => "root[trans]"
      assert_select "input#root_kind", :name => "root[kind]"
    end
  end
end
