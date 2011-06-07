require 'spec_helper'

describe "searches/edit.html.erb" do
  before(:each) do
    @search = assign(:search, stub_model(Search,
      :search => "MyString",
      :user_id => 1,
      :lang => "MyString",
      :category => "MyString",
      :page => 1,
      :option => false
    ))
  end

  it "renders the edit search form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => searches_path(@search), :method => "post" do
      assert_select "input#search_search", :name => "search[search]"
      assert_select "input#search_user_id", :name => "search[user_id]"
      assert_select "input#search_lang", :name => "search[lang]"
      assert_select "input#search_category", :name => "search[category]"
      assert_select "input#search_page", :name => "search[page]"
      assert_select "input#search_option", :name => "search[option]"
    end
  end
end
