class Message

  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :story


  field :content, type: String
  field :owner, type: String
  field :status, type: String

  def set_owner_and_status(user_params)
    self.status = 'approved'
    self.owner = user_params[:email]
    self.save
  end

  def set_content(story_params)
    self.content = story_params[:content]
    self.save
  end
end