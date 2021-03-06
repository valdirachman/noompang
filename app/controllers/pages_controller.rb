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

    respond_to do |format|
      format.html
      format.js
    end
  end

  def home_drivers
    ids = current_user.friends.map{|f| f.id} << current_user.id
    posts = DriverPost.self_and_friends (ids)
    posts = posts.today
    @posts = posts.paginate(page: params[:page], per_page: 10)
    @newPost = DriverPost.new
    @profile = current_user.profile

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

    respond_to do |format|
      format.html
      format.js
    end
  end

  def profile
    #grab the username from the URL as :id
    @current_user ||= User.find_by(id: session[:user_id])
    @user = User.find_by_username(params[:id])
    if (@user)
      @username = params[:id]
      @profile = @user.profile
      #posts = Post.all.where("user_id = ?", @user.id)

      posts = @user.posts
      @posts = posts.paginate(page: params[:page], per_page: 10)
      @newPost = Post.new

      friends = @user.friends
      @recommended_friends = []
      if (not friends.empty?)
        new_friends = friends.find_not_friends(current_user)
        @recommended_friends = User.where(id: new_friends.map(&:id).sample(4)) - [current_user]
      else
        new_friends = User.find_not_friends(current_user)
        @recommended_friends = User.where(id: new_friends.map(&:id).sample(4)) - [current_user]
      end

      respond_to do |format|
        format.html
        format.js
      end
    else
      respond_to do |f|
        f.html { redirect_to home_path, notice: "User not found!" }
      end
    end
  end

  def explore
    @posts = Post.all
  end

  def explore_people
    friends = current_user.friends
    @recommended_friends = []
    if (not friends.empty?)
      reference_friend = friends.find(friends.pluck(:id).shuffle.first)
      friends_of_reference_friend = reference_friend.friends.find_not_friends(current_user)
      @recommended_friends = User.where(id: friends_of_reference_friend.map(&:id).sample(50)) - [current_user]
      if @recommended_friends.empty?
        new_friends = User.find_not_friends(current_user)
        @recommended_friends = User.where(id: new_friends.map(&:id).sample(50)) - [current_user]
      end
    else
      new_friends = User.find_not_friends(current_user)
      @recommended_friends = User.where(id: new_friends.map(&:id).sample(50)) - [current_user]
    end
  end

  def notification
    @requests = current_user.pending_invited_by
    @join_requests = DirectBooking.pending_of_user(current_user.id)
    @pickup_requests = IndirectBooking.pending_of_user(current_user.id)
    @profile = current_user.profile
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

  def active_rides
    @rider_posts = Post.where(user_id: current_user.id).today
    @driver_posts = DriverPost.where(user_id: current_user.id).today
    @profile = current_user.profile
  end

  def rides
    @current_user ||= User.find_by(id: session[:user_id])
    @user = User.find_by_username(params[:id])
    if (@user)
      @username = params[:id]
      @profile = @user.profile
      #posts = Post.all.where("user_id = ?", @user.id)

      posts = @user.posts
      @posts = posts.paginate(page: params[:page], per_page: 10)
      @newPost = Post.new

      friends = @user.friends
      @recommended_friends = []
      if (not friends.empty?)
        new_friends = friends.find_not_friends(current_user)
        @recommended_friends = User.where(id: new_friends.map(&:id).sample(4)) - [current_user]
      else
        new_friends = User.find_not_friends(current_user)
        @recommended_friends = User.where(id: new_friends.map(&:id).sample(4)) - [current_user]
      end

      respond_to do |format|
        format.html
        format.js
      end
    else
      respond_to do |f|
        f.html { redirect_to home_path, notice: "User not found!" }
      end
    end
  end

  def about_us

  end

  def how_it_works

  end

  def FAQ

  end

  def stories

  end

  def terms_and_conditions
  end
end
