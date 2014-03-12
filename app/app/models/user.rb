require 'bcrypt'

class User
  include Mongoid::Document
  include Mongoid::Timestamps

  attr_accessor :password, :password_confirmation

  field :email, type: String
  field :salt, type: String
  field :fish, type:String

  before_save :encrypt_password

  def authentication(password)
    self.fish == BCrypt::Engine.hash_secret(password, self.salt)
  end


  protected

  def encrypt_password
    puts "Encrypting the password #{self.password}"
    if password.present?
      self.salt = BCrypt::Engine.generate_salt
      self.fish = BCrypt::Engine.hash_secret(password, self.salt)
    end
  end
end