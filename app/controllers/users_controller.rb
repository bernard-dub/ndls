class UsersController < ApplicationController
    
  def update
    @user = User.find(params[:id])
    @user.update(profanity:params[:profanity])
    flash[:notice] = "Préférences mises à jour vers : #{@user.profanity}"
    redirect_back fallback_location: root_path
  end
end
