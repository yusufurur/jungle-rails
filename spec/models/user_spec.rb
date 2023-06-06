require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it "it shouldn't create a user if password and password_confirmations don't match" do
      @user = User.create(name: "John Doe", email: "johndoe@gmail.com", password: "123456", password_confirmation: "1234567")
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    it "it should create a matching password and password_confirmations " do
      @user = User.create(name: "John Doe", email: "johndoe@gmail.com", password: "12345678", password_confirmation: "12345678")
      expect(@user).to be_valid
    end
    it "shouldn't create an account if the password is too short" do
      @user = User.create(name: "John Doe", email: "johndoe@gmail.com", password: "123456", password_confirmation: "12456")
      @user.save
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 8 characters)")
    end
  end

  describe '.authenticate_with_credentials' do
    it "it shouldn't allow the user to login if the e-mail isn't found" do
      @user = User.create(name: "John Doe", email: "hellothere@gmail.com", password: "1234567", password_confirmation: "1234567")
      @user2 = User.authenticate_with_credentials('hellotheree@gmail.com', '1234567')
      expect(@user2).to be_nil
    end
    it "it should allow the user to login if the e-mail is found" do
      @user = User.create(name: "John Doe", email: "johndoe@gmail.com", password: "12345678")
      @user2 = User.authenticate_with_credentials('johndoe@gmail.com', '12345678')
      expect(@user2).to be_truthy
    end
    it "it should allow the user to login if the e-mail is found with spaces before and/or after the email address" do
      @user = User.create(name: "John Doe", email: "johndoe@gmail.com", password: "12345678")
      @user2 = User.authenticate_with_credentials('johndoe@gmail.com ', '12345678')
      expect(@user2).to be_truthy
    end
    it "it should allow the user to login if the e-mail is found with different cases" do
      @user = User.create(name: "John Doe", email: 'johndoe@gmail.com', password: "12345678")
      @user2 = User.authenticate_with_credentials('JohnDoe@gmail.com', '12345678')
      expect(@user2).to be_truthy
    end
  end
end