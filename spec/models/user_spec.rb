require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validations" do

    before(:each) do
      @user = User.create(first_name: "Hamza", last_name: "Asim", email: "test@test.com", password: "hamza123", password_confirmation: "hamza123")
    end

    it "registration will be vaild when all the required field are full" do
      expect(@user).to be_valid
    end
    
    it "email should be unique and not case sensitive" do
      @newUser = User.create(first_name: "hyusadh", last_name: "Asim", email: "TEST@TEST.com", password: "hasbdc", password_confirmation: "hasbdc")
      expect(@newUser).to be_invalid
      expect(@newUser.errors.full_messages).to include("Email has already been taken")
    end

    it "email shoud not be blank" do
      @user.email = nil
      expect(@user).to be_invalid
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it "first_name should not be blank" do
      @user.first_name = nil
      expect(@user).to be_invalid
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end
    
    it "password and password_confirmation should match" do
      @user.password = nil
      @user.password_confirmation = nil
      expect(@user).to be_invalid
      expect(@user.errors.full_messages).to include("Password can't be blank")
      @user.password = "hamza123"
      @user.password_confirmation = "123456"
      expect(@user).to be_invalid
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it "password minimun length should be 6 character" do
      @user.password = "abcde"
      @user.password_confirmation = "abcde"
      expect(@user).to be_invalid
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end

  end

  describe '.authenticate_with_credentials' do
    it "valid email and password" do
      @user = User.create(first_name: "Hamza", last_name: "Asim", email: "test@test.com", password: "abcde", password_confirmation: "abcde")
      user1 = User.authenticate_with_credentials("test@test.com", "abcde")
      expect(user1).to be_present
    end
    it "need vaild email" do
      user = User.authenticate_with_credentials("telol@b.com", "abcde")
      expect(user).to be_nil
    end

    it "user pass even enter capital letter in email" do
      user = User.authenticate_with_credentials("tesTlol@b.com", "abcde")
      expect(user).to be_present
    end

    it "user pass even enter white space before or after email" do
      user = User.authenticate_with_credentials(" testlol@b.com ", "abcde")
      expect(user).to be_present
    end
  end
end
