require 'rails_helper'

RSpec.feature "Sessions", type: :feature do
  describe "signing in" do
    let!(:user) { create(:user) }

    context "successful login" do
      it "redirects to home page, show a message 'Logged in'
            and shows user full name" do

        visit new_session_path

        fill_in "Email", with: user.email
        fill_in "Password", with: user.password

        click_button "Sign In"

        expect(current_path).to eq(root_path)
        expect(page).to have_text /Logged In/i
        expect(page).to have_text /#{user.full_name}/i
      end
    end

    context "unsuccesful login" do
      it "stays on the same and see a message saying Wrong Credentials! and dont see
          you're name on the page" do
          visit new_session_path

          # in this case it will look for a input field with id email
          fill_in "Email", with: user.email
          fill_in "Password", with: user.email

          click_button "Sign In"

          expect(current_path).to eq(sessions_path)
          expect(page).to have_text /Wrong Credentials!/i
          expect(page).not_to have_text /#{user.full_name}/i
      end
    end
  end
end
