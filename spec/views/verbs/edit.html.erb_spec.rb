require 'spec_helper'

describe "verbs/edit.html.erb" do
  before(:each) do
    @verb = assign(:verb, stub_model(Verb,
      :verb => "MyString",
      :conj => "MyString",
      :mood => "MyString",
      :tense => "MyString",
      :tense_type => "MyString",
      :pro => "MyString",
      :pre => "MyString"
    ))
  end

  it "renders the edit verb form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => verbs_path(@verb), :method => "post" do
      assert_select "input#verb_verb", :name => "verb[verb]"
      assert_select "input#verb_conj", :name => "verb[conj]"
      assert_select "input#verb_mood", :name => "verb[mood]"
      assert_select "input#verb_tense", :name => "verb[tense]"
      assert_select "input#verb_tense_type", :name => "verb[tense_type]"
      assert_select "input#verb_pro", :name => "verb[pro]"
      assert_select "input#verb_pre", :name => "verb[pre]"
    end
  end
end
