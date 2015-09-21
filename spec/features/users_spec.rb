require 'rails_helper'

RSpec.feature "Users", type: :feature do
  describe "Signing Up" do

    context "with valid parameters" do
      it "redirects to the home page and creates a user in the database" do

        before_count = User.count
        # visiting the sign up page
        visit new_user_path

        validate_attributes = attributes_for(:user)

        # with fill_in you can use either the id of the input field or the
        # text for associated label with that input field
        fill_in "First name",            with: validate_attributes[:first_name]
        fill_in "Last name",             with: validate_attributes[:last_name]
        fill_in "Email",                 with: validate_attributes[:email]
        fill_in "Password",              with: validate_attributes[:password]
        fill_in "Password confirmation", with: validate_attributes[:password]

        click_button "Create User"

        after_count = User.count

        expect(current_path).to eq(root_path)
        expect(after_count - before_count).to eq(1)

      end
    end
  end
end
