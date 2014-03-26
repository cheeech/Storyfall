class MessageController < ApplicationController

  before_action :is_authenticated?

  def new_message new_message
    self.content = new_message
    self.content.save
  end



end