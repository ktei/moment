require 'spec_helper'

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

    describe "access control" do
      it "should deny access" do
        get :albums
        response.should redirect_to(sign_in_path)
      end
    end

    describe "left nav bar" do
      before(:each) do
        @user = FactoryGirl.create(:user)
        sign_in_as(@user)
      end
      describe "when current user has albums" do
        before(:each) do
          @album1 = FactoryGirl.create(:album, :user => @user, :title => 'foobar1')
          @album2 = FactoryGirl.create(:album, :user => @user, :title => 'foobar2')
        end
        it "should render links for all albums of current user" do
          get :albums
          response.should have_selector("a", :content => @album1.title)
          response.should have_selector("a", :content => @album2.title)
        end

        it "should highlight the first album link when no album_id is passed" do
          get :albums
          response.should have_selector("li.active", :content => @user.albums.first.title)
        end

        it "should highlight active album link when corresponding album_id is passed" do
          get :albums, :album_id => @album2
          response.should have_selector("li.active", :content => @album2.title)
        end
        it "should raise 404 error when no given album is found" do
          lambda do
            get :albums, :album_id => @album2.id + 1000
          end.should raise_error(ActionController::RoutingError)
        end
      end

      describe "when current user has no album" do
        it "should inform user there is no album found" do
          get :albums
          response.should have_selector('div.secondary', :content => 'No album')
        end
      end


    end

    describe "display photos" do
      before(:each) do
        @user = FactoryGirl.create(:user)
        @album = FactoryGirl.create(:album, :user => @user)
        @photos = []
        sign_in_as(@user)
      end
      it "should show have an element for each photo" do
        2.times do
          @photos << FactoryGirl.create(:photo, :album => @album,
            :image => File.new(Rails.root + 'spec/fixtures/images/sample.jpg'))
        end
        get :albums, :album_id => @album.id
        @photos[0..2].each do |photo|
          response.should have_selector "img[src*=sample]"
        end
      end
    end
  end
end