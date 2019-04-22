class TrackListenerController < ApplicationController
  def index
    @user = current_user
    @tracks = Track.all
  end
end
