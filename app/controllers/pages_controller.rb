class PagesController < ApplicationController
  def index
  end

  def home
    ids = current_user.friends.map{|f| f.id} << current_user.id
    @posts = Post.self_and_friends (ids)
    @newPost = Post.new
    @profile = current_user.profile
  end

  def profile
    #grab the username from the URL as :id
    @user = User.find_by_username(params[:id])
    if (@user)
      @username = params[:id]
    else
      redirect_to root_path, :notice=> "User not found!"
    end

    @profile = @user.profile
    @posts = Post.all.where("user_id = ?", @user.id)
    @newPost = Post.new
  end

  def explore
    @posts = Post.all
  end

  def friend_request
    @requests = current_user.pending_invited_by
  end
end
