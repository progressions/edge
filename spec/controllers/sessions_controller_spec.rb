require 'spec_helper'

describe SessionsController do

  describe "GET 'new'" do
    it "returns http success" do
      get :new
      expect(response).to be_success
    end
  end

  describe "POST 'create'" do
    before(:each) do
      @user = create(:user)
    end

    context "with valid credentials" do
      it "redirects to root" do
        post :create, email: @user.email, password: @user.password
        expect(response).to redirect_to(root_url)
      end

      it "saves user id to session" do
        post :create, email: @user.email, password: @user.password
        expect(session[:user_id]).to eq(@user.id)
      end
    end

    context "with invalid credentials" do
      it "doesn't log in" do
        post :create, email: @user.email, password: "yermom"
        expect(session[:user_id]).to be_nil
      end

      it "renders new" do
        post :create, email: @user.email, password: "yermom"
        expect(response).to render_template(:new)
      end
    end
  end

  describe "DELETE 'destroy'" do
    it "logs out" do
      @user = create(:user)
      delete :destroy
      expect(session[:user_id]).to be_nil
    end
  end
end
