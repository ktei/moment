class AlbumsController < ApplicationController
  before_filter :authorize

  def create
    @album = current_user.albums.build(params[:album])
    if @album.save
      redirect_to library_path
    else
      render 'library/new_album'
    end
  end
end