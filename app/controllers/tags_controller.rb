class TagsController < ApplicationController
  def index
    @tags = Tag.all
    @user = current_user
  end

  def create
    ids = params['options']
    ids = [] if ids.nil?
    current_user.set_user_tags(ids)
    redirect_to root_path
  end

  def show
    @tag = Tag.find(params[:id])
    trackTag = TrackTag.where(tag_id: params[:id])
    track_ids = trackTag.select(:track_id)
    @tracks = Track.where(id: track_ids)
  end
end
