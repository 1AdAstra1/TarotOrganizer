#encoding: utf-8
require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe SpreadsController do
  
  before :each do
    @client = Client.create!({:name => 'test', :comment => 'test', :start_date => '2010-11-21'})
    @spread = Spread.create! valid_attributes
  end

  # This should return the minimal set of attributes required to create a valid
  # Spread. As you add validations to Spread, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {:name => 'Test spread', :client_id => @client.id, :structure => '{"width":"497px","height":"262px","border":"","backgroundColor":"rgb(73, 109, 73)","deck":"rider-waite","size":"large","positions":[{"width":"173px","height":"123px","position":"absolute","top":"59px","left":"50px","fontSize":"24px","textAlign":"center","backgroundColor":"rgb(238, 238, 238)","border":"","number":{"value":1,"mode":"horizontal","textAlign":"left","position":"relative","top":"61.5px","marginTop":"-12px","marginLeft":"10px","marginRight":"10px"},"description":"rderyrwety","card":{"image":"/assets/rider-waite/lovers.jpg","width":66,"height":115,"reverted":true,"id":"lovers","name":"Влюблённые","value":"retyretyrety rtyretyer","marginTop":"3px","marginBottom":"3px"}},{"width":"123px","height":"173px","position":"absolute","top":"61px","left":"325px","fontSize":"24px","textAlign":"center","backgroundColor":"rgb(238, 238, 238)","border":"","number":{"value":2,"mode":"vertical","textAlign":"center","position":"static","top":"auto","marginTop":"3px","marginLeft":"0px","marginRight":"0px"},"description":"rtyrtyrety","card":{"image":"/assets/rider-waite/cups-8.jpg","width":80,"height":140,"reverted":false,"id":"cups-8","name":"8 Чаш","value":"111","marginTop":"0px","marginBottom":"0px"}}]}', :date => '2012-07-15'}
  end
  
  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # SpreadsController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all spreads as @spreads" do
      get :index, {}, valid_session
      assigns(:spreads).should eq([@spread])
    end
  end

  describe "GET show" do
    it "assigns the requested spread as @spread and its JSON-parsed structure to @structure" do
      get :show, {:id => @spread.to_param}, valid_session
      assigns(:spread).should eq(@spread)
      assigns(:structure).should eq(JSON.parse(@spread.structure))
    end
  end

  describe "GET new" do
    it "assigns a new spread as @spread" do
      get :new, {}, valid_session
      assigns(:spread).should be_a_new(Spread)
    end
  end

  describe "GET edit" do
    it "assigns the requested spread as @spread" do
      get :edit, {:id => @spread.to_param}, valid_session
      assigns(:spread).should eq(@spread)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Spread" do
        expect {
          post :create, {:spread => valid_attributes}, valid_session
        }.to change(Spread, :count).by(1)
      end

      it "assigns a newly created spread as @spread" do
        post :create, {:spread => valid_attributes}, valid_session
        assigns(:spread).should be_a(Spread)
        assigns(:spread).should be_persisted
      end

      it "redirects to the created spread" do
        post :create, {:spread => valid_attributes}, valid_session
        response.should redirect_to(Spread.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved spread as @spread" do
        # Trigger the behavior that occurs when invalid params are submitted
        Spread.any_instance.stub(:save).and_return(false)
        post :create, {:spread => {}}, valid_session
        assigns(:spread).should be_a_new(Spread)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Spread.any_instance.stub(:save).and_return(false)
        post :create, {:spread => {}}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested spread" do
        spread = Spread.create! valid_attributes
        # Assuming there are no other spreads in the database, this
        # specifies that the Spread created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Spread.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => spread.to_param, :spread => {'these' => 'params'}}, valid_session
      end

      it "assigns the requested spread as @spread" do
        spread = Spread.create! valid_attributes
        put :update, {:id => spread.to_param, :spread => valid_attributes}, valid_session
        assigns(:spread).should eq(spread)
      end

      it "redirects to the spread" do
        spread = Spread.create! valid_attributes
        put :update, {:id => spread.to_param, :spread => valid_attributes}, valid_session
        response.should redirect_to(spread)
      end
    end

    describe "with invalid params" do
      it "assigns the spread as @spread" do
        spread = Spread.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Spread.any_instance.stub(:save).and_return(false)
        put :update, {:id => spread.to_param, :spread => {}}, valid_session
        assigns(:spread).should eq(spread)
      end

      it "re-renders the 'edit' template" do
        spread = Spread.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Spread.any_instance.stub(:save).and_return(false)
        put :update, {:id => spread.to_param, :spread => {}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested spread" do
      spread = Spread.create! valid_attributes
      expect {
        delete :destroy, {:id => spread.to_param}, valid_session
      }.to change(Spread, :count).by(-1)
    end

    it "redirects to the spreads list" do
      spread = Spread.create! valid_attributes
      delete :destroy, {:id => spread.to_param}, valid_session
      response.should redirect_to(spreads_url)
    end
  end

end
