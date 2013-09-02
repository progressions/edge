require 'spec_helper'

describe UsersController do

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      expect(response).to be_success
    end
  end

  describe "POST 'create'" do
    context "without attributes" do
      it "creates a user" do
        expect {
          post :create
        }.to change(User, :count).by(1)
      end

      it "creates a guest" do
        post :create
        expect(User.last).to be_guest
      end
    end

    context "with valid attributes" do
      it "redirects to root" do
        post :create, user: attributes_for(:user)
        expect(response).to redirect_to(root_url)
      end

      it "creates the user" do
        expect {
          post :create, user: attributes_for(:user)
        }.to change(User, :count).by(1)
      end

      it "redirects to create character if params[:create_character]" do
        post :create, user: attributes_for(:user), create_character: true
        expect(response).to redirect_to(new_character_url)
      end

      it "logs in the user" do
        post :create, user: attributes_for(:user), create_character: true
        expect(session[:user_id]).to eq(User.last.id)
      end
    end

    context "with invalid attributes" do
      it "renders new" do
        post :create, user: attributes_for(:user, password: nil)
        expect(response).to render_template(:new)
      end

      it "doesn't create user" do
        expect {
          post :create, user: attributes_for(:user, password: nil)
        }.not_to change(User, :count).by(1)
      end
    end
  end
end
