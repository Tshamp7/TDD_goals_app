require 'rails_helper'

RSpec.describe User, type: :model do
  context "validations" do
    describe "user validations" do
      it { should validate_presence_of(:email) }
      it { should validate_presence_of(:password_digest).with_message("Password can't be blank") }
      it { should validate_length_of(:password).is_at_least(6).on(:create) }
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
      it "should set the password equal to a BCrypt hashed password" do
        unhashed_password = "Example1234"
        test_user = User.create(email: "example@example.com", password: unhashed_password )
        expect(test_user.password).not_to be(unhashed_password)
      end
    end

    describe "generate_session_token" do
      it "generates a random 16 character number to act as the session token" do
        test_user = User.create(email: "example@example.com", password: "Example1234")
        test_user.generate_session_token
        expect(test_user.session_token.length).to be(16)
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

    describe "ensure_session_token" do
      it "should ensure a session token is assigned" do
        test_user = User.create(email: "example@example.com", password: "Example1234")
        test_user.ensure_session_token
        expect(test_user.session_token).not_to be(nil)
      end
    end
  end

  context "class methods" do
    describe "find_by_credentials" do
      it "should find the user with the supplied credentials if they exist" do
        test_user = User.create(email: "example@example.com", password: "Example1234")
        expect(User.find_by_credentials(email:"example@example.com", password: "Example1234")).to be(test_user)
      end
    end
  end

end
