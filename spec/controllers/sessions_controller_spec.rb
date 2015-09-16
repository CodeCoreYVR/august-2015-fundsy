require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  # view the form that will be submitting the login email / password
  describe "#new" do
    it "renders the new template" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  # recieving the email / password and logging the person in or showing error
  describe "#create" do
    # Let will define a method called user that is accessible anywhere within
    # this context (or describe).
    # If you never call the method `user` it will not create it, unless you
    # use let!
    let(:user) { create(:user) }

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
      it "doesn't set the session id"
      it "renders the new template"
      it "sets a flash message"
    end
  end

  # for logging out
  describe "#destroy" do

  end
end
