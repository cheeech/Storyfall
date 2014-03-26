class Message

include Mongoid::Document
include Mongoid::Timestamps

belongs_to :story
has_many :contributions


field :content, type: String



end