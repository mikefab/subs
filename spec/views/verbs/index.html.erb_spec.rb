require 'spec_helper'

describe "verbs/index.html.erb" do
  before(:each) do
    assign(:verbs, [
      stub_model(Verb,
        :verb => "Verb",
        :conj => "Conj",
        :mood => "Mood",
        :tense => "Tense",
        :tense_type => "Tense Type",
        :pro => "Pro",
        :pre => "Pre"
      ),
      stub_model(Verb,
        :verb => "Verb",
        :conj => "Conj",
        :mood => "Mood",
        :tense => "Tense",
        :tense_type => "Tense Type",
        :pro => "Pro",
        :pre => "Pre"
      )
    ])
  end

  it "renders a list of verbs" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Verb".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Conj".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Mood".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Tense".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Tense Type".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Pro".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Pre".to_s, :count => 2
  end
end
