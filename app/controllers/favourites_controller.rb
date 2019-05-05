class FavouritesController < ApplicationController
  skip_before_action :verify_authenticity_token
  def create
    user = current_user
    if params["trackId"].present?
      track_id = params["trackId"].to_i
      tracks = Track.where(id: track_id)
      user.swap_track_favourites(tracks)
    end
  end

  def index
    @user = current_user
    @tracks = current_user.favourites
  end
end
