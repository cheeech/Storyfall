class SessionController < ApplicationController

  def new
    # render text: "Display the log in form."
    # @messages = flash.map {|key, value| "#{key.capitalize}: #{value}"}.join(";")

    redirect_to root_url, notice: "You are already logged in." if current_user

  end

  def create
    # render text: "Log the user in."
    user = User.find_by(email: params[:user][:email])
    password = params[:user][:password]

    if user and password.blank?
      user.set_password_reset
      UserNotifier.reset_password(user).deliver
      flash.now[:notice] = "We'll send you an email.."
      render :new

    elsif user and user.authenticate(password)
      session[:user_id] = user.id
      redirect_to root_url

    else
      flash.now[:alert] = "Unable to log you in. Please check your email and password and try again"
      render :new
    end

  end

  def destroy
    session[:user_id] = nil
    # render text: "Log the user out."
    redirect_to login_url, notice: "You've successfully logged out."

  end

end