class Contribution

  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :messages

  field :content, type: String

end