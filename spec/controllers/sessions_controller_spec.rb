require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  # Let will define a method called user that is accessible anywhere within
  # this context (or describe).
  # If you never call the method `user` it will not create it, unless you
  # use let!
  let(:user) { create(:user) }

  # view the form that will be submitting the login email / password
  describe "#new" do
    it "renders the new template" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  # recieving the email / password and logging the person in or showing error
  describe "#create" do

    context "with valid credentials" do

      before do
        # When
        post(:create, {email: user.email, password: user.password})
      end

      it "sets the session id to the user id" do
        # Then
        expect(session[:user_id]).to eq(user.id)
      end

      it "redirects to home page" do
        # Then
        expect(response).to redirect_to(root_path)
      end

      it "sets a flash message" do
        # Then
        expect(flash[:notice]).to be
      end

    end
    context "with invalid credentials" do
      before do
        post :create, email: user.email, password: nil
      end

      it "doesn't set the session id" do
        expect(session[:user_id]).not_to be
      end

      it "renders the new template" do
        expect(response).to render_template(:new)
      end

      it "sets a flash message" do
        expect(flash[:alert]).to be
      end
    end
  end

  # for logging out
  describe "#destroy" do
    before do
      # Given
      login(user)
      # When
      delete :destroy
    end

    it "sets the session[:user_id] to nil" do
      # Then
      expect(session[:user_id]).to be_nil
    end

    it "redirects to the home page" do
      expect(response).to redirect_to root_path
    end

    it "sets a flash message" do
      expect(flash[:notice]).to be
    end
  end
end
