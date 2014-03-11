require 'spec_helper'

describe UsersController do

  before (:each) do
    @user = FactoryGirl.create(:user)
    sign_in @user
  end

  describe "GET 'index'" do 
    it "doesn't allow non admin to display users list" do
      get :index
      expect(response).to redirect_to root_path
    end

    it "renders the users list" do 
      @user.add_role :admin
      xhr :get, :index
      expect(response).to render_template('users/_users_list')
    end

    it "renders the users list" do 
      @user.add_role :admin
      get :index
      expect(response).to render_template('users/index')
    end
  end

  describe "GET 'show'" do
    it "should be successful" do
      get :show, id: @user.id
      response.should be_success
    end
    
    it "should find the right user" do
      get :show, id: @user.id
      assigns(:user).should == @user
    end  
  end

  describe "PUT 'update'" do 
    it "doesn't allow non admin to update a user" do
      put :update, {id: @user.id}
      expect(response).to redirect_to root_path
    end
  end

  describe "DELETE 'destroy'" do 
    it "doesn't allow non admin to delete a user" do
      delete :destroy, {id: @user.id}
      expect(response).to redirect_to root_path
    end
  end

  describe "POST 'authentication_key'" do 
    it "returns the authentication key" do 
      post :authentication_key, email: @user.email, password: 'changeme' 
      expect(response.body).to eql @user.authentication_token
    end

    it "returns invalid email" do 
      post :authentication_key, email: "wrong@email.com", password: 'changeme' 
      expect(response.body).to eql "Invalid user"
    end

    it "returns invalid password" do 
      post :authentication_key, email: @user.email, password: 'wrong_pwd' 
      expect(response.body).to eql "Invalid password"
    end
  end
end
