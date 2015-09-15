require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "#new" do
    it "instantiate a new user model object" do
      # because we have RSpec.describe UsersController at the beginning of this
      # file. We're able to mimik a get / post / patch / delete requests
      # by simply calling a method, for instance, get and then pass it the
      # action name. So in this case we can just call: get :new
      # we're also able to pass parameters with the request as we will see later
      get :new
      # When testing for instance variables. We can use `assigns` method and
      # pass it the name of the variable we expect it to be assigned as an
      # instance variable (@user).
      # be_a_new is an RSpec matcher that checks that the object given to the
      # expect is a new instance of whatever class you pass
      expect(assigns(:user)).to be_a_new(User)
    end

    it "renders the new template" do
      get :new
      # we have access to an object "response" that helps us test for things
      # like rendering a template to redirecting to a url
      expect(response).to render_template(:new)
    end
  end

  describe "#create" do
    context "with valid parameters" do
      def valid_params
        {
          first_name:            Faker::Name.first_name,
          last_name:             Faker::Name.last_name,
          email:                 Faker::Internet.email,
          password:              "supersecret",
          password_confirmation: "supersecret"
        }
      end

      def valid_request
        post(:create, {user: valid_params})
      end

      it "adds a user recrod to the database" do
        # count_before = User.count
        # post(:create, {user: valid_params})
        # count_after  = User.count
        # expect(count_after - count_before).to eq(1)
        expect { valid_request }.to change { User.count }.by(1)
      end

      it "redirects to the home page" do
        valid_request
        # expect(response).to(redirect_to(root_path))
        expect(response).to redirect_to root_path
      end

      it "automatically signs the user in" do
        valid_request
        expect(session[:user_id]).to eq(User.last.id)
      end

      it "sets a flash message" do
        valid_request
        expect(flash[:notice]).to be
      end
    end

    context "with invalid parameters" do
      def invalid_params
        {
          first_name:            Faker::Name.first_name,
          last_name:             Faker::Name.last_name,
          email:                 nil,
          password:              "supersecret",
          password_confirmation: "supersecret"
        }
      end

      def invalid_request
        post(:create, {user: invalid_params})
      end

      it "doesn't create a record in the database" do
        expect { invalid_request }.not_to change { User.count }
      end

      it "render the new template" do
        invalid_request
        expect(response).to render_template(:new)
      end

      it "sets a flash message" do
        invalid_request
        expect(flash[:alert]).to be
      end
    end
  end

end
