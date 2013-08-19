require 'spec_helper'
require 'clearance/testing'

describe LibraryController do
  render_views

  describe "GET 'new_album'" do
    describe "when not signed in" do
      it "should deny access" do
        get :new_album
        response.should redirect_to(sign_in_path)
      end
    end

    describe "when signed in" do
      before(:each) do
        sign_in
        get :new_album
      end

      it "should be successful" do
        response.should be_success
      end

      it "should have the right title" do
        response.should have_selector("title", :content => "New album")
      end

      it "should have 'Create new album' hyperlink bolded" do
        response.should have_selector("li.active a", :content => "Create new album")
      end
    end
  end
end