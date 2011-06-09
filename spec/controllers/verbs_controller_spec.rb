require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by the Rails when you ran the scaffold generator.

describe VerbsController do

  def mock_verb(stubs={})
    @mock_verb ||= mock_model(Verb, stubs).as_null_object
  end

  describe "GET index" do
    it "assigns all verbs as @verbs" do
      Verb.stub(:all) { [mock_verb] }
      get :index
      assigns(:verbs).should eq([mock_verb])
    end
  end

  describe "GET show" do
    it "assigns the requested verb as @verb" do
      Verb.stub(:find).with("37") { mock_verb }
      get :show, :id => "37"
      assigns(:verb).should be(mock_verb)
    end
  end

  describe "GET new" do
    it "assigns a new verb as @verb" do
      Verb.stub(:new) { mock_verb }
      get :new
      assigns(:verb).should be(mock_verb)
    end
  end

  describe "GET edit" do
    it "assigns the requested verb as @verb" do
      Verb.stub(:find).with("37") { mock_verb }
      get :edit, :id => "37"
      assigns(:verb).should be(mock_verb)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "assigns a newly created verb as @verb" do
        Verb.stub(:new).with({'these' => 'params'}) { mock_verb(:save => true) }
        post :create, :verb => {'these' => 'params'}
        assigns(:verb).should be(mock_verb)
      end

      it "redirects to the created verb" do
        Verb.stub(:new) { mock_verb(:save => true) }
        post :create, :verb => {}
        response.should redirect_to(verb_url(mock_verb))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved verb as @verb" do
        Verb.stub(:new).with({'these' => 'params'}) { mock_verb(:save => false) }
        post :create, :verb => {'these' => 'params'}
        assigns(:verb).should be(mock_verb)
      end

      it "re-renders the 'new' template" do
        Verb.stub(:new) { mock_verb(:save => false) }
        post :create, :verb => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested verb" do
        Verb.stub(:find).with("37") { mock_verb }
        mock_verb.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :verb => {'these' => 'params'}
      end

      it "assigns the requested verb as @verb" do
        Verb.stub(:find) { mock_verb(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:verb).should be(mock_verb)
      end

      it "redirects to the verb" do
        Verb.stub(:find) { mock_verb(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(verb_url(mock_verb))
      end
    end

    describe "with invalid params" do
      it "assigns the verb as @verb" do
        Verb.stub(:find) { mock_verb(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:verb).should be(mock_verb)
      end

      it "re-renders the 'edit' template" do
        Verb.stub(:find) { mock_verb(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested verb" do
      Verb.stub(:find).with("37") { mock_verb }
      mock_verb.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the verbs list" do
      Verb.stub(:find) { mock_verb }
      delete :destroy, :id => "1"
      response.should redirect_to(verbs_url)
    end
  end

end