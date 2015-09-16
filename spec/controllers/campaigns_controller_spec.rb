require 'rails_helper'

RSpec.describe CampaignsController, type: :controller do
  let(:user)     { create(:user)     }
  let(:campaign) { create(:campaign) }

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

  describe "#show" do
    before { get :show, id: campaign.id }

    it "instantiates a campaign variable with the Campaign whose id is passed" do
      expect(assigns(:campaign)).to eq(campaign)
    end

    it "it renders the show template" do
      expect(response).to render_template(:show)
    end
  end

  describe "#index" do
    let(:campaign_1) { create(:campaign) }

    it "assigns an instance variable @campaigns to all created campaigns" do
      # we're calling campaign and campaign_1 in order for them to be created
      # in the database before we make the request
      campaign
      campaign_1
      get :index
      expect(assigns(:campaigns)).to eq([campaign, campaign_1])
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template(:index)
    end
  end

end
