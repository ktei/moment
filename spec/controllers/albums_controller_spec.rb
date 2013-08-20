require 'spec_helper'
require 'clearance/testing'


describe AlbumsController do
  render_views

  describe "access control" do
    it "should deny access to 'create'" do
      post :create
      response.should redirect_to(sign_in_path)
    end

    it "should deny access to 'destroy'" do
      post :create
      response.should redirect_to(sign_in_path)
    end
  end

  describe "POST 'create'" do
    before(:each) do
      @user = FactoryGirl.create(:user)
      sign_in_as(@user)
    end

    it "should not create an album without title" do
      lambda do
        post :create, :album => { title: "" }
      end.should_not change(Album, :count)
    end

    it "should not create an album if title is too long" do
      lambda do
        post :create, :album => { title: "a" * 141 }
      end.should_not change(Album, :count)
    end

    it "should not create an album if description is too long" do
      lambda do
        post :create, :album => { description: "a" * 501 }
      end.should_not change(Album, :count)
    end

    describe "success" do
      before(:each) do
        @attr = { title: "Lorem ipsum", description: "a" * 150 }
      end
      it "should create an album" do
        lambda do
          post :create, :album => @attr
        end.should change(Album, :count).by(1)
      end

      it "should redirect to the page of the new created album" do
        post :create, :album => @attr
        response.should redirect_to(library_path)
      end
    end
  end
end