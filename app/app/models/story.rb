class Story

  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user
  has_many :messages


  field :keeper, type: String
  field :title, type: String
  field :index, type: String
  field :contributors, type: String

end
