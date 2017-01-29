class PagesController < ApplicationController
  def index
  end

  def home
    ids = current_user.friends.map{|f| f.id} << current_user.id
    posts = Post.self_and_friends (ids)
    posts = posts.today
    @posts = posts.paginate(page: params[:page], per_page: 10)
    @newPost = Post.new
    @profile = current_user.profile
    @friends = current_user.friends
    byebug
    if (@friends)
      reference_friend = friends.find(friends.pluck(:id).shuffle.first)
      friends_of_reference_friend = reference_friend.friends
      @recommended_friends = friends_of_reference_friend.where(id: friends_of_reference_friend.pluck(:id).sample(5)) - [current_user]
    end

    respond_to do |format|
      format.html
      format.js
    end
  end

  def profile
    #grab the username from the URL as :id
    @user = User.find_by_username(params[:id])
    if (@user)
      @username = params[:id]
      @profile = @user.profile
      #posts = Post.all.where("user_id = ?", @user.id)
      posts = @user.posts.today
      @posts = posts.paginate(page: params[:page], per_page: 10)
      @newPost = Post.new
      friends = @user.friends
      @recommended_friends = friends.where(id: friends.pluck(:id).sample(5)) - [current_user]
      respond_to do |format|
        format.html
        format.js
      end
    else
      redirect_to root_path, :notice=> "User not found!"
    end
  end

  def explore
    @posts = Post.all
  end

  def friend_request
    @requests = current_user.pending_invited_by
  end
end
