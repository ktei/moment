class DashboardController < ApplicationController
  before_filter :authorize

  def albums
    @title = 'Dashboard'
  end

  def upload
    @title = 'Dashboard'
  end
end