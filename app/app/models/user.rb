require 'bcrypt'

class User
  include Mongoid::Document
  include Mongoid::Timestamps

  attr_accessor :password, :password_confirmation

  field :email, type: String
  field :salt, type: String
  field :fish, type:String

  before_save :set_random_password, :encrypt_password

  validates :email, presence: true, uniqueness: {case_sensitive: false}

  def self.authenticate(email, password)
    user = User.find_by email: email
    user if user and user.authenticate(password)
  end


  def authenticate(password)
    self.fish == BCrypt::Engine.hash_secret(password, self.salt)
  end


  protected

  def set_random_password
    if self.fish.blank? and password.blank?
      self.salt = BCrypt::Engine.generate_salt
      self.fish = BCrypt::Engine.hash_secret(SecureRandom.base64(32), self.salt)
    end
  end

  def encrypt_password
    puts "Encrypting the password #{self.password}"
    if password.present?
      self.salt = BCrypt::Engine.generate_salt
      self.fish = BCrypt::Engine.hash_secret(password, self.salt)
    end
  end
end