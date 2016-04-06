class RelationshipsController < ApplicationController
  def create
    user = User.find params[:followed_id]
    current_user.follow user
    redirect_to user
  end

  def destroy
    user = current_user.active_relationships.find_by(id: params[:id]).followed
    current_user.unfollow user
    redirect_to user
  end
end
