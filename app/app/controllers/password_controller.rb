  class PasswordController < ApplicationController

  LINK_EXPIRED = "Your reset link has expired, Please generate a new one"
  PASSWORD_RESET = "Your password has been successfully reset."

  def edit
    unless @user = User.find_by_code( params[:code] )
      redirect_to login_url, notice: LINK_EXPIRED
    end
  end

  def update
    if @user = User.find_by_code( params[:code] )
    # if user is found
      if PasswordResetter.new(flash).update_password( @user, user_params )
        return if log_user_in( @user, PASSWORD_RESET )
        # redirect_to( root_url, notice: PASSWORD_RESET ) and return
      else
        flash.now[:alert] = @user.errors
      end

    # otherwise show a message not found
    else
      flash.now[:alert] = LINK_EXPIRED
    end
    render :edit

  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end


end