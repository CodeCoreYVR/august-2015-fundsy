require 'rails_helper'

# DSL: Domain Specific Language - In here for RSpec
RSpec.describe User, type: :model do
  def valid_attributes(new_attributes = {})
    {first_name: "Tom",
     last_name:  "Smith",
     email:      "tom@smith.com",
     password:   "supersecret"
   }.merge(new_attributes)
  end

  # describe in here starts a new section of test scenarios / examples
  describe "Validations" do
    it "requires an email" do
      user = User.new valid_attributes({email: nil})
      expect(user).to be_invalid
    end

    it "requires a first name" do
      user = User.new valid_attributes({first_name: nil})
      expect(user).to be_invalid
    end

    it "requires a password" do
      # Given - a new user with all valid attributes except for a missing password
      user = User.new valid_attributes({password: nil})
      # When - you try to save the user record
      user.save
      # Then - you get an attached errors that include a :password key
      # expect(user.errors.messages.has_key?(:password)).to eq(true)
      expect(user.errors.messages).to have_key(:password)
    end

    it "requires an email with a valid format" do
      user = User.new(valid_attributes({email: "asdfasdfasdf"}))
      expect(user).to be_invalid
    end

  end

  describe ".full_name" do
    it "returns the concatenated first name and last name if given" do
      user = User.new(valid_attributes({first_name: "Tom", last_name: "Smith"}))
      expect(user.full_name).to eq("Tom Smith")
    end

    it "returns the first name only if the last name is missing" do
      user = User.new(valid_attributes({first_name: "Tom", last_name: nil}))
      expect(user.full_name).to eq("Tom")
    end

  end

  describe "generating password hash" do

    it "generates a password digest" do
      user = User.new(valid_attributes)
      user.save
      expect(user.password_digest).to be
    end

  end

end
