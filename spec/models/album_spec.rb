require 'spec_helper'

describe Album do
  describe "photo associations" do
    before(:each) do
      @user = FactoryGirl.create(:user)
      @album = FactoryGirl.create(:album, :user => @user)
    end

    it "should have a photos attribute" do
      @album.should respond_to(:photos)
    end
  end
end
