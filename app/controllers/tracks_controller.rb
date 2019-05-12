class TracksController < ApplicationController
  def index
    if current_user.tags.empty?
      redirect_to tags_path
    end
    @user = current_user
    tracksFilter = params[:track]
    @tracks = nil

    if (tracksFilter == nil)
      userTags = UserTag.where(user_id: @user.id)
      tag_ids = userTags.select(:tag_id)
      trackTag = TrackTag.where(tag_id: tag_ids)
      track_ids = trackTag.select(:track_id)
      @tracks = Track.where(id: track_ids)
      @header_title = "Your relevant tracks"
    else
      @header_title = "Your search results for: " + tracksFilter
      @tracks = Track.where("lower(title) LIKE :query", query: "%#{tracksFilter.downcase}%")
    end
  end
end
