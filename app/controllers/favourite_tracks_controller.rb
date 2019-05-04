class FavouriteTracksController < ApplicationController
  def index
    @user = current_user
    @tracks = current_user.favourites
  end
end
