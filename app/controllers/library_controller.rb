class LibraryController < ApplicationController
  before_filter :authorize

  def albums
    @title = 'Library - Albums'
    if not params.has_key?(:album_id)
      @album = current_user.albums.first
    else
      @album = current_user.albums.where(id: params[:album_id]).first || not_found
    end
  end

  def new_album
    @title = 'Library - New album'
    @album = current_user.albums.build
  end

  def upload
    @title = 'Library - Upload'
  end
end