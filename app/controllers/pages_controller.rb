class PagesController < ApplicationController

  before_filter :authorize, :except => ['index']

  def index
    if signed_in?
      redirect_to dashboard_path
    else
      @ignore_container = true
      render :template => 'pages/home'
    end
  end
  
  def gallery
    @title = 'Gallery'
  end
end