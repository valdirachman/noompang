class ProfilesController < ApplicationController
  def show
    @profile = current_user.profile
  end

  def edit
    # use this to populate a form in your view
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

  def avatar
    @profile = current_user.profile
  end

  def car
    @profile = current_user.profile
  end

  def verification
    @profile = current_user.profile
  end


  def update
    @profile = current_user.profile
    if @profile.update_attributes(profile_params)
      redirect_to edit_profile_path(current_user.profile)
    else
      if @profile.errors.any?
        flash[:notice] = @profile.errors.full_messages.first
      end
      redirect_to edit_profile_path(@profile)
      #render 'edit'
    end
  end

  private
  def profile_params
    params.require(:profile).permit(:name, :description, :occupation, :occupation_place, :avatar, :hobby, :age, :gender, :university, :major, :about, :phone)
  end
end
