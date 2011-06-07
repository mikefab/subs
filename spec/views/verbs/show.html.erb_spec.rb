require 'spec_helper'

describe "verbs/show.html.erb" do
  before(:each) do
    @verb = assign(:verb, stub_model(Verb,
      :verb => "Verb",
      :conj => "Conj",
      :mood => "Mood",
      :tense => "Tense",
      :tense_type => "Tense Type",
      :pro => "Pro",
      :pre => "Pre"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Verb/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Conj/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Mood/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Tense/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Tense Type/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Pro/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Pre/)
  end
end
