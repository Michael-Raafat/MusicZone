class TagsController < ApplicationController
  def index
    @tags = Tag.all
    @user = current_user
  end

  def create
    ids = params['options']
    current_user.set_user_tags(ids)
    redirect_to root_path
  end
end