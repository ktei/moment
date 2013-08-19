class DashboardController < ApplicationController
  before_filter :authorize

  def albums
    @title = 'Dashboard - Albums'
  end

  def upload
    @title = 'Dashboard - Upload'
  end
end