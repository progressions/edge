# == Schema Information
#
# Table name: careers
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  career_skills :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#

require 'spec_helper'

describe Career do
  describe "class methods" do
    before(:each) do
      Career.seed!
    end

    it "seeds 6 careers" do
      expect(Career.count).to eq(6)
    end

    it "seeds 18 specializations" do
      expect(Career.count).to eq(6)
      expect(Specialization.count).to eq(18)
    end
  end
end
