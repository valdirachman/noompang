class FriendsController < ApplicationController
  def add
    #@posts = Post.following (current_user.following)
    other = User.find(params[:id])
    current_user.invite other
    redirect_to(:back)
  end

  def accept
    other = User.find(params[:id])
    current_user.approve other
    redirect_to(:back)
  end

  def see_friends
    @user = User.find_by_username(params[:id])
    if @user
      @friends = @user.friends
    else
      redirect_to root_path
      return
    end
  end
end
