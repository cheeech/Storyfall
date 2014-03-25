class Story

  include Mongoid::Document
  include Mongoid::Timestamps

  has_many :messages

  field :creator, type: String
  field :title, type: String
  field :index, type: String

  # def create_story title message
  #   story = Story.new
  #   story.title = title
  #   # story.message = message
  #   story.save
  # end

end
