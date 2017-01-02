class PagesController < ApplicationController
  def index
  end

  def home
    @posts = Post.friends (current_user.friends)
    #@posts = Post.all
    @newPost = Post.new
  end

  def profile
    #grab the username from the URL as :id
    if (User.find_by_username(params[:id]))
      @username = params[:id]
    else
      redirect_to root_path, :notice=> "User not found!"
    end
    
    @posts = Post.all.where("user_id = ?", User.find_by_username(params[:id]).id)
    @newPost = Post.new
  end

  def explore
    @posts = Post.all
  end
  
  def friend_request
    @requests = current_user.pending_invited_by
  end
end
