class SessionController < ApplicationController

  def new
    render text: "Display the log in form."
  end

  def create
    # render text: "Log the user in."
    render text: User.authenticate(params[:user][:email], params[:user][:password])
  end

  def destroy
    render text: "Log the user out."
  end

end