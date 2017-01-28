class UsersController < ApplicationController
  def index
    if params[:search]
      if params[:search] == ""
        redirect_to root_path
      else
        @users = User.search(params[:search]).order("created_at DESC").limit(10)
      end
    else
      redirect_to root_path
    end
  end
end
