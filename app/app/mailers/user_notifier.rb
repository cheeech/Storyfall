class UserNotifier < ActionMailer::Base

  default from: "StoryFall <webmaster@StoryFall.com>"

  def reset_password(user)
    @user = user
    mail to: @user.email, subject: "[StoryFall] Reset your credentials"
  end


  def password_was_reset(user)
  end


end