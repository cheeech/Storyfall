class SessionController < ApplicationController

  def new
    # render text: "Display the log in form."
    # @messages = flash.map {|key, value| "#{key.capitalize}: #{value}"}.join(";")

  end

  def create
    # render text: "Log the user in."
    @user = User.authenticate(params[:user][:email], params[:user][:password])

    if @user
      session[:user_id] = @user.id
      # render text: "Logged in yo! #{@user.email}"
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