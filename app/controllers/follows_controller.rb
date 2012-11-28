class FollowsController < ApplicationController
  def create
    @follow = current_user.follows.build(:follower_id => params[:follower_id])
    if @follow.save
      respond_to do |format|
        format.html {redirect_to root_url, :notice => "You Follow to a new user."}
        format.js
      end
    else
      respond_to do |format|
        format.html {redirect_to root_url, :alert => "You can't be Follow this user."}
        format.js
      end
    end    
  end

  def destroy
    @follow = current_user.follows.find(params[:id])
    @follow.destroy
    flash[:notice] = "Now you don't follow this user."
    redirect_to root_path
  end

end
