require 'rails_helper'

RSpec.describe CampaignsController, type: :controller do
  let(:user) { create(:user) }

  describe "#new" do
    context "user not signed in" do
      it "redirect to login page" do
        get :new
        expect(response).to redirect_to new_session_path
      end
    end
    context "user signed in" do
      before do
        login(user)
      end

      it "renders the new campaign template" do
        get :new
        expect(response).to render_template(:new)
      end

      it "instantiates a new campaign object" do
        get :new
        expect(assigns(:campaign)).to be_a_new(Campaign)
      end
    end
  end

  describe "#create" do
    context "with user not signed in" do
      it "redirects to sign in page"
    end

    context "with user signed in" do
      context "with valid parameters" do
        it "creates a campaign in the database"
        it "redirects to campaign show page"
        it "sets a flash message"
        it "associates the created campaign with the logged in user"
      end

      context "with invalid parameters" do
        it "doesn't create a record in the database"
        it "renders the new template"
      end
    end
  end

end
