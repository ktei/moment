require 'spec_helper'

describe User do
  describe "album associations" do
    before(:each) do
      @user = FactoryGirl.create(:user)
    end

    it "should have a albums attribute" do
      @user.should respond_to(:albums)
    end
  end
end