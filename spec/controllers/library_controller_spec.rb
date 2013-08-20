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

  describe "GET 'library'" do
    describe "when not signed in" do
      it "should deny access" do
        get :albums
        response.should redirect_to(sign_in_path)
      end
    end

    describe "when signed in" do
      before(:each) do
        @user = FactoryGirl.create(:user)
        @album1 = FactoryGirl.create(:album, :user => @user, :title => 'foobar1')
        @album2 = FactoryGirl.create(:album, :user => @user, :title => 'foobar2')
        sign_in_as(@user)
      end

      it "should render links for all albums of current user" do
        get :albums
        response.should have_selector("a", :content => @album1.title)
        response.should have_selector("a", :content => @album2.title)
      end

      describe "and current user has albums" do
        it "should highlight the first album link when no album_id is passed" do
          get :albums
          response.should have_selector("li.active", :content => @user.albums.first.title)
        end

        it "should highlight active album link when corresponding album_id is passed" do
          get :albums, :album_id => @album2
          response.should have_selector("li.active", :content => @album2.title)
        end
      end

      describe "and current user has no album" do

      end

      it "should redirect to library_path when invalid album_id is passed" do
        get :albums, :albums_id => @album2.id + 1000
        # The code below indicates that the user has been redirected to
        # /library path so the first album will be active by default.
        response.should have_selector("li.active", :content => @user.albums.first.title)
      end
    end
  end
end