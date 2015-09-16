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
      it "redirects to sign in page" do
        post :create
        expect(response).to redirect_to new_session_path
      end
    end

    context "with user signed in" do
      before { login(user) }

      context "with valid parameters" do

        def valid_request
          post :create, campaign: attributes_for(:campaign)
        end

        it "creates a campaign in the database" do
          expect { valid_request }.to change { Campaign.count }.by(1)
        end

        it "redirects to campaign show page" do
          valid_request
          expect(response).to redirect_to campaign_path(Campaign.last)
        end

        it "sets a flash message" do
          valid_request
          expect(flash[:notice]).to be
        end

        it "associates the created campaign with the logged in user" do
          valid_request
          expect(Campaign.last.user).to eq(user)
        end
      end

      context "with invalid parameters" do
        def invalid_request
          post :create, campaign: {title: nil}
        end

        it "doesn't create a record in the database" do
          expect { invalid_request }.to change { Campaign.count }.by(0)
        end

        it "renders the new template" do
          invalid_request
          expect(response).to render_template(:new)
        end
      end
    end
  end

end
