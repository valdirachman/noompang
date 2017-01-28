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
      redirect_to home_path
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
    params.require(:profile).permit(:name, :description, :occupation, :occupation_place, :avatar)
  end
end
