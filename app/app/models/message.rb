class Message

include Mongoid::Document
include Mongoid::Timestamps

belongs_to :story


field :content, type: String
field :owner, type: String
field :status, type: String



end