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

describe UseCasesController do

  before (:each) do
    @user = FactoryGirl.create(:user)
    sign_in @user
  end

  # This should return the minimal set of attributes required to create a valid
  # UseCase. As you add validations to UseCase, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { "key" => "MyString" } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # UseCasesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all use_cases as @use_cases" do
      use_case = UseCase.create! valid_attributes
      get :index, {}, valid_session
      assigns(:use_cases).should eq([use_case])
    end
  end

  describe "GET show" do
    it "assigns the requested use_case as @use_case" do
      use_case = UseCase.create! valid_attributes
      get :show, {:id => use_case.to_param}, valid_session
      assigns(:use_case).should eq(use_case)
    end
  end

  describe "GET new" do
    it "assigns a new use_case as @use_case" do
      get :new, {}, valid_session
      assigns(:use_case).should be_a_new(UseCase)
    end
  end

  describe "GET edit" do
    it "assigns the requested use_case as @use_case" do
      use_case = UseCase.create! valid_attributes
      get :edit, {:id => use_case.to_param}, valid_session
      assigns(:use_case).should eq(use_case)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new UseCase" do
        expect {
          post :create, {:use_case => valid_attributes}, valid_session
        }.to change(UseCase, :count).by(1)
      end

      it "assigns a newly created use_case as @use_case" do
        post :create, {:use_case => valid_attributes}, valid_session
        assigns(:use_case).should be_a(UseCase)
        assigns(:use_case).should be_persisted
      end

      it "redirects to the created use_case" do
        post :create, {:use_case => valid_attributes}, valid_session
        response.should redirect_to(UseCase.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved use_case as @use_case" do
        # Trigger the behavior that occurs when invalid params are submitted
        UseCase.any_instance.stub(:save).and_return(false)
        post :create, {:use_case => { "key" => "invalid value" }}, valid_session
        assigns(:use_case).should be_a_new(UseCase)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        UseCase.any_instance.stub(:save).and_return(false)
        post :create, {:use_case => { "key" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested use_case" do
        use_case = UseCase.create! valid_attributes
        # Assuming there are no other use_cases in the database, this
        # specifies that the UseCase created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        UseCase.any_instance.should_receive(:update).with({ "key" => "MyString" })
        put :update, {:id => use_case.to_param, :use_case => { "key" => "MyString" }}, valid_session
      end

      it "assigns the requested use_case as @use_case" do
        use_case = UseCase.create! valid_attributes
        put :update, {:id => use_case.to_param, :use_case => valid_attributes}, valid_session
        assigns(:use_case).should eq(use_case)
      end

      it "redirects to the use_case" do
        use_case = UseCase.create! valid_attributes
        put :update, {:id => use_case.to_param, :use_case => valid_attributes}, valid_session
        response.should redirect_to(use_case)
      end
    end

    describe "with invalid params" do
      it "assigns the use_case as @use_case" do
        use_case = UseCase.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        UseCase.any_instance.stub(:save).and_return(false)
        put :update, {:id => use_case.to_param, :use_case => { "key" => "invalid value" }}, valid_session
        assigns(:use_case).should eq(use_case)
      end

      it "re-renders the 'edit' template" do
        use_case = UseCase.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        UseCase.any_instance.stub(:save).and_return(false)
        put :update, {:id => use_case.to_param, :use_case => { "key" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested use_case" do
      use_case = UseCase.create! valid_attributes
      expect {
        delete :destroy, {:id => use_case.to_param}, valid_session
      }.to change(UseCase, :count).by(-1)
    end

    it "redirects to the use_cases list" do
      use_case = UseCase.create! valid_attributes
      delete :destroy, {:id => use_case.to_param}, valid_session
      response.should redirect_to(use_cases_url)
    end
  end

end
