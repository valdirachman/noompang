class FriendsController < ApplicationController
  def add
    #@posts = Post.following (current_user.following)
    other = User.find(params[:id])
    current_user.friend_request(other)
    redirect_to(:back)
  end
end
