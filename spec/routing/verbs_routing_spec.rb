require "spec_helper"

describe VerbsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/verbs" }.should route_to(:controller => "verbs", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/verbs/new" }.should route_to(:controller => "verbs", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/verbs/1" }.should route_to(:controller => "verbs", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/verbs/1/edit" }.should route_to(:controller => "verbs", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/verbs" }.should route_to(:controller => "verbs", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/verbs/1" }.should route_to(:controller => "verbs", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/verbs/1" }.should route_to(:controller => "verbs", :action => "destroy", :id => "1")
    end

  end
end
