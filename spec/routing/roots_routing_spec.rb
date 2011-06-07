require "spec_helper"

describe RootsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/roots" }.should route_to(:controller => "roots", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/roots/new" }.should route_to(:controller => "roots", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/roots/1" }.should route_to(:controller => "roots", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/roots/1/edit" }.should route_to(:controller => "roots", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/roots" }.should route_to(:controller => "roots", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/roots/1" }.should route_to(:controller => "roots", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/roots/1" }.should route_to(:controller => "roots", :action => "destroy", :id => "1")
    end

  end
end
