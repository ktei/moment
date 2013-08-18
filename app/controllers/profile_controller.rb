class ProfileController < ApplicationController
  before_filter :authorize

  def show
    @title = 'Profile'
  end

  def edit
    @title = "Edit profile"
  end

  def update
    if current_user.update_attributes(params[:user])
      redirect_to profile_path
    else
      render 'profile/edit'
    end
  end
end