class TracksController < ApplicationController
  def index
    if current_user.tags.empty?
      redirect_to tags_path
    end

    @user = current_user
    userTags = UserTag.where(user_id: @user.id)
    tag_ids = userTags.select(:tag_id)
    trackTag = TrackTag.where(tag_id: tag_ids)
    track_ids = trackTag.select(:track_id)
    @tracks = Track.where(id: track_ids)
  end
end
