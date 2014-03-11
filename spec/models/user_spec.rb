require 'spec_helper'

describe User do
  let(:time) { Time.now }

  before(:each) do
    @attr = {
      name: "Example User",
      email: "user@example.com",
      password: "changeme",
      password_confirmation: "changeme",
      confirmed_at: time
    }
  end

  it "should create a new instance given a valid attribute" do
    User.create!(@attr)
  end

  it "should create a new user with geocode informations set" do
    @u = User.create!(@attr.merge(postal_address: "Paris, France"))
    expect(@u.state).not_to be_nil
    expect(@u.country_code).not_to be_nil
    expect(@u.jvectormap_state_code).not_to be_nil
  end

  it "should create a facebook user" do
    oa = OmniAuth::AuthHash.new({ provider: 'facebook', uid: '123545', info: {email: "test@test.fr"},extra: {raw_info: { name: "Test" } } })
    expect{ User.find_for_facebook_oauth(oa) }.to change{User.count}.by(1)
  end

  it "should create a google user" do 
    token = mock_model('Token', {info: {"email" => "test@test.fr"}, name: "Test"})
    expect{ User.find_for_google_oauth(token) }.to change{User.count}.by(1)
  end

  it "should require an email address" do
    no_email_user = User.new(@attr.merge(email: ""))
    no_email_user.should_not be_valid
  end

  it "should accept valid email addresses" do
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      valid_email_user = User.new(@attr.merge(email: address))
      valid_email_user.should be_valid
    end
  end

  it "should reject invalid email addresses" do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    addresses.each do |address|
      invalid_email_user = User.new(@attr.merge(email: address))
      invalid_email_user.should_not be_valid
    end
  end

  it "should reject duplicate email addresses" do
    User.create!(@attr)
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end

  it "should reject email addresses identical up to case" do
    upcased_email = @attr[:email].upcase
    User.create!(@attr.merge(email: upcased_email))
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end

  describe "passwords" do
    before(:each) do
      @user = User.new(@attr)
    end

    it "should have a password attribute" do
      @user.should respond_to(:password)
    end

    it "should have a password confirmation attribute" do
      @user.should respond_to(:password_confirmation)
    end
  end

  describe "password validations" do
    it "should require a password" do
      User.new(@attr.merge(password: "", password_confirmation: "")).
        should_not be_valid
    end

    it "should require a matching password confirmation" do
      User.new(@attr.merge(password_confirmation: "invalid")).
        should_not be_valid
    end

    it "should reject short passwords" do
      short = "a" * 5
      hash = @attr.merge(password: short, password_confirmation: short)
      User.new(hash).should_not be_valid
    end
  end

  describe "password encryption" do
    before(:each) do
      @user = User.create!(@attr)
    end

    it "should have an encrypted password attribute" do
      @user.should respond_to(:encrypted_password)
    end

    it "should set the encrypted password attribute" do
      @user.encrypted_password.should_not be_blank
    end
  end

end
