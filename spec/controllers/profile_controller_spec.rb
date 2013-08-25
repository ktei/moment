require 'spec_helper'

describe ProfileController do
  render_views

  describe "GET 'show'" do
    describe "when not signed in" do
      it "should deny access" do
        get :show
        response.should redirect_to(sign_in_path)
      end
    end

    describe "when signed in" do
      before(:each) do
        sign_in_as(FactoryGirl.create(:user))
        get :show
      end
      it "should be successful" do
        response.should be_success
      end

      it "should have the right title" do
        response.should have_selector("title", :content => "Profile")
      end
    end
  end

  describe "GET 'edit'" do
    describe "when not signed in" do
      it "should deny access" do
        get :edit
        response.should redirect_to(sign_in_path)
      end
    end

    describe "when signed in" do
      before(:each) do
        sign_in_as(FactoryGirl.create(:user))
        get :edit
      end
      it "should be successful" do
        response.should be_success
      end

      it "should have the right title" do
        response.should have_selector("title", :content => "Edit profile")
      end
    end
  end

  describe "PUT 'update'" do
    describe "when not signed in" do
      it "should deny access" do
        put :update
        response.should redirect_to(sign_in_path)
      end
    end
  end

end