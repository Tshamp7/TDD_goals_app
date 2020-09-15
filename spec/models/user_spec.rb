require 'rails_helper'

RSpec.describe User, type: :model do
  context "validations" do
    describe "user validations" do
      subject{ User.create(email: "thebestemail@example.com", password: "Example1234") }
      it { should validate_presence_of(:email) }
      it { should validate_uniqueness_of(:email) }
      it { should validate_presence_of(:password_digest).with_message("Password can't be blank") }
      it { should validate_length_of(:password).is_at_least(6).on(:create) }
      it { should validate_presence_of(:session_token) }
    end
  end

  context "Instance methods" do
    describe "is_password?" do
      it "should check the submitted password against a BCrypt hashed password" do
        test_user = User.create(email: "example@example.com", password: "Example1234")
        expect(test_user.is_password?("Example1234")).to be(true)
      end
    end

    describe "password=" do
      it "should set the password_digest to a BCrypt hashed password" do
        unhashed_password = "Example1234"
        test_user = User.create(email: "example@example.com", password: unhashed_password )
        expect(test_user.password_digest).not_to be(unhashed_password)
      end
    end

    describe "ensure_session_token" do
      it "generates and sets session token attribute to a random 16 character string" do
        test_user = User.create(email: "example@example.com", password: "Example1234")
        test_user.ensure_session_token
        expect(test_user.session_token).not_to be(nil)
      end
    end

    describe "reset_session_token!" do
      it "should reset the session token" do
        test_user = User.create(email: "example@example.com", password: "Example1234")
        token1 = test_user.session_token
        test_user.reset_session_token!
        expect(test_user.session_token).not_to be(token1)
      end
    end
    
  end

  context "class methods" do
    describe "find_by_credentials" do
      it "should find the user with the supplied credentials if they exist" do
        test_user = User.create(email: "example2@example.com", password: "Example1234")
        expect(User.find_by_credentials("example2@example.com", "Example1234")).to eq(test_user)
      end
    end
  end

end
