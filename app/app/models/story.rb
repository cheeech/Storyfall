class Story

  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user
  has_many :messages


  field :keeper, type: String
  field :title, type: String
  field :index, type: String
  field :contributors, type: Array

  def set_title_and_index ( story_params )
    self.title = story_params[:title]
    self.index = Story.count + 1
  end

  def set_keeper_to_user_email (user_params)
    user = User.find_by({:email => user_params.email})
    self.keeper = user.email
    self.push(contributors: user.email)
    self.save
  end
end
