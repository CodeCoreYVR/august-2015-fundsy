require 'rails_helper'

RSpec.feature "Campaigns", type: :feature do
  describe "Home page" do
    it "displays a welcome message" do
      visit campaigns_path
      expect(page).to have_text "Welcome to Fund.sy"
    end

    it "has a title that says: Fund.sy, your modern crowdfunding solution" do
      visit campaigns_path
      expect(page).to have_title "Fund.sy, your modern crowdfunding solution"
    end

    it "has an h2 that says all campaigns" do
      visit campaigns_path
      # save_and_open_page # this uses the launchy gem
      expect(page).to have_selector "h2", text: "All campaigns"
    end

    it "displays a campaign's title" do
      campaign = create(:campaign)
      visit campaigns_path
      expect(page).to have_text /#{campaign.title}/i
    end
  end
end
