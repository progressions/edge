# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string(255)
#  password_digest :string(255)
#  guest           :boolean
#  created_at      :datetime
#  updated_at      :datetime
#

require 'spec_helper'

describe User do
  describe "class methods" do
    it "creates a new guest user" do
      @user = User.new_guest
      expect(@user).to be_guest
    end
  end

  describe "instance methods" do
    before(:each) do
      @user = build(:user)
    end

    it "has a valid factory" do
      expect(@user).to be_valid
    end

    describe "validations" do
      it "requires password unless guest" do
        @user = build(:user, password: nil, password_confirmation: nil)
        expect(@user).not_to be_valid
      end

      it "requires email unless guest" do
        @user.email = nil
        expect(@user).not_to be_valid
      end

      it "doesn't require password if guest" do
        @guest = create(:guest, password: nil, password_confirmation: nil)
        expect(@guest).to be_valid
      end

      it "doesn't require email if guest" do
        @guest = create(:guest, email: nil)
        expect(@guest).to be_valid
      end
    end

    it "gives name as 'guest'" do
      @guest = create(:guest)
      expect(@guest.name).to eq("Guest")
    end

    it "gives name as email" do
      expect(@user.name).to eq(@user.email)
    end

    it "moves characters from guest user to real user" do
      @user.save
      @guest = create(:guest)
      @character = create(:character, user: @guest)

      @guest.move_to(@user)
      @character.reload
      expect(@character.user).to eq(@user)
    end
  end
end
