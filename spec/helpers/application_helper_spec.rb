require 'spec_helper'

describe ApplicationHelper do
  describe "identifier" do
    it "downcases" do
      expect(identifier("Twi'lek")).to eq("twilek")
    end

    it "removes spaces" do
      expect(identifier("a thing")).to eq("athing")
    end
  end
end
