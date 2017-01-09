class ProfilesController < ApplicationController
  def show
    @profile = current_user.profile
  end

  def edit
    # use this to populate a form in your view
    @profile = current_user.profile
  end

  def update
    @profile = current_user.profile
    if @profile.update_attributes(profile_params)
      redirect_to user_profile_path(current_user.username)
    else
      render 'edit'
    end
  end

  private
  def profile_params
    params.require(:profile).permit(:name, :description, :occupation, :occupation_place)
  end
end
