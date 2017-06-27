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
    @profile = current_user.profile
    @user = User.find_by_username(params[:id])
    if @user
      @friends = @user.friends
    else
      redirect_to root_path
      return
    end

    friends = current_user.friends
    @recommended_friends = []
    if (not friends.empty?)
      reference_friend = friends.find(friends.pluck(:id).shuffle.first)
      friends_of_reference_friend = reference_friend.friends.find_not_friends(current_user)
      @recommended_friends = User.where(id: friends_of_reference_friend.map(&:id).sample(4)) - [current_user]
      if @recommended_friends.empty?
        new_friends = User.find_not_friends(current_user)
        @recommended_friends = User.where(id: new_friends.map(&:id).sample(4)) - [current_user]
      end
    else
      new_friends = User.find_not_friends(current_user)
      @recommended_friends = User.where(id: new_friends.map(&:id).sample(4)) - [current_user]
    end
    
  end
end
