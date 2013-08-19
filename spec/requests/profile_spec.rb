require 'spec_helper'

describe "Profile" do
  before(:each) do
    @user = FactoryGirl.create(:user)
    visit sign_in_path
    fill_in :email, :with => @user.email
    fill_in :password, :with => @user.password
    click_button
  end

  describe "show" do
    it "should show signed-in user's info" do
      visit profile_path
      response.should have_selector("div", :content => @user.name)
    end
  end

  describe "edit" do
    it "should have proper editable fields with signed-in user's info" do
      visit profile_edit_path
      response.should have_selector("input", :value => @user.name)
    end
  end

  describe "cancel" do
    it "should not save changes and navigate back to profile_show page" do
      visit profile_edit_path
      original_name = @user.name
      fill_in "user_name", :with => (@user.name += '_changed')
      click_link 'Cancel'
      response.should render_template('profile/show')
      response.should have_selector("div", :content => original_name)
    end
  end

  describe "update" do
    it "should update a valid name" do
      visit profile_edit_path
      fill_in "user_name", :with => @user.name << '_changed'
      click_button
      response.should render_template('profile/show')
      response.should have_selector("div", :content => @user.name)
    end
  end
end