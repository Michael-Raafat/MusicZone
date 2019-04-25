class TrackListenerController < ApplicationController
  def index
    @user = current_user
    tags = @user.user_tags
    trackTag = TrackTag.where(tag_id: tags.ids)
    track_ids = trackTag.select(:track_id)
    @tracks = Track.where(id: track_ids)
  end
end
