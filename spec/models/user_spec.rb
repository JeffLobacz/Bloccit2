require 'rails_helper'

RSpec.describe User, type: :model do

  let(:user) { User.create!(name: "Bloccit User", email: "user@bloccit.com", password: "password") }

  #Shoulda tests for Name
  it { should validate_presence_of(:name) }
  it { should validate_length_of(:name).is_at_least(1) }

  # Shoulda tests for email
  it { should validate_presence_of(:email) }
  it {
     allow(user).to receive(:my_cap)
     should validate_uniqueness_of(:email)
   }
  it { should validate_length_of(:email).is_at_least(3) }
  it { should allow_value("user@bloccit.com").for(:email) }
  it { should_not allow_value("userbloccit.com").for(:email) }

  #Shoulda tests for password
  it { should validate_presence_of(:password) }
  it { should have_secure_password }
  it { should validate_length_of(:password).is_at_least(6) }

  describe "attributes" do

    it "should respond to name" do
      expect(user).to respond_to(:name)
    end

    it "should respond to email" do
      expect(user).to respond_to(:email)
    end

  end

  # methods
  describe "format_name" do

<<<<<<< HEAD
    let(:user1) { User.create!(name: "bloccit user", email: "user@bloccit.com", password: "password") }

    # before do
    #   user1 = User.new(name: "bloccit user", email: "user@bloccit.com", password: "password")
    #   # user2 = User.new(name: "bloccit", email: "user@bloccit.com", password: "password")
    # end
=======
    let(:user1) { User.new(name: "bloccit user", email: "user@bloccit.com", password: "password") }
    let(:user2) { User.new(name: "bloccit", email: "user@bloccit.com", password: "password") }
>>>>>>> master

    it "capitalizes names with more than one word" do
      user1.save
      expect(user1.name).to eq("Bloccit User")
    end

<<<<<<< HEAD
    # it "capitalizes a one-word name" do
    #   user2.save
    #   expect(user2.name).to eq("Bloccit")
    # end
=======
    it "capitalizes a one-word name" do
      user2.save
      expect(user2.name).to eq("Bloccit")
    end
>>>>>>> master

  end

  describe "invalid user" do
    let(:user_with_invalid_name) { User.new(name: "", email: "user@bloccit.com") }
    let(:user_with_invalid_email) { User.new(name: "Bloccit User", email: "") }
    let(:user_with_invalid_email_format) { User.new(name: "Bloccit User", email: "invalid_format") }

    it "should be an invalid user due to blank name" do
      expect(user_with_invalid_name).to_not be_valid
    end

    it "should be an invalid user due to blank email" do
      expect(user_with_invalid_email).to_not be_valid
    end

    it "should be an invalid user due to incorrectly formatted email address" do
      expect(user_with_invalid_email_format).to_not be_valid
    end

  end

end
