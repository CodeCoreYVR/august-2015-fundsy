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
      it "stays on the same and see a message saying can't login and dont see
          you're name on the page" do

      end
    end
  end
end
