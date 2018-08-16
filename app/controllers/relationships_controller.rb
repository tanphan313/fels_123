class RelationshipsController < ApplicationController
  def create
    @user = User.find params[:followed_id]
    current_user.follow @user
    respond_to do |format|
      format.html
      format.js
    end
  end

  def destroy
    @user = current_user.active_relationships.find_by(id: params[:id]).followed
    current_user.unfollow @user
    respond_to do |format|
      format.html
      format.js
    end
  end
end
