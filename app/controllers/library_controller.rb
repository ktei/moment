class LibraryController < ApplicationController
  before_filter :authorize

  def albums
    @title = 'Library - Albums'
    @albums = [] if not params.has_key?(:album_id)
  end

  def new_album
    @title = 'Library - New album'
    @album = current_user.albums.build
  end

  def upload
    @title = 'Library - Upload'
  end
end