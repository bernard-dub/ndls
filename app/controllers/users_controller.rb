class UsersController < ApplicationController
    
  def update
    params.require(:user).permit(:profanity)
    @user = User.find(params[:id])
    @user.update(profanity:params[:user][:profanity])
    flash[:notice] = "Préférences mises à jour vers #{@user.profanity}"
    redirect_to root_path
  end
end
