class LikedTracksController < ApplicationController
  def index
    @user = current_user
    @tracks = current_user.likes
  end
end
