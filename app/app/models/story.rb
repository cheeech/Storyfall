class Story

  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user
  has_many :messages

  field :keeper, type: String
  field :title, type: String
  field :index, type: String

  # def create_story title message
  #   story = Story.new
  #   story.title = title
  #   # story.message = message
  #   story.save
  # end

end
