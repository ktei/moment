require 'spec_helper'
require 'clearance/testing'

describe PagesController do
  render_views

  before(:each) do
    @base_title = "Moment"
  end

  describe "GET 'index'" do
    describe "when not signed in" do
      before(:each) do
        get :index
      end

      it "should be successful" do
        response.should be_success
      end

      it "should have the right title" do
        response.should have_selector("title", :content => "#{@ase_title}")
      end
    end

    describe "when signed in" do
      before(:each) do
        sign_in_as(FactoryGirl.create(:user))
        get :index
      end

      it "should redirect to Dashboard" do
        response.should redirect_to(dashboard_path)
      end
    end
  end
end