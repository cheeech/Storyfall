require 'spec_helper'

describe User do
  it "is valid with an email" do
    user = User.new(
        email: 'harry@ga.co'
      )
    expect(user).to be_valid
    # expect(true).to be_true
  end

  it "is invalid without an email" do
    user = User.new
    expect(user).to be_invalid
  end

  it "is valid when code is set when resetting password" do
    user = User.new
    user.set_password_reset
    expect(user.code).not_to be_nil
  end

  it "is valid when expiration_at is not nil now when resetting password" do
    user = User.new
    user.set_password_reset
    expect(user.expires_at).not_to be_nil
  end

  it "is valid when expiration_at is set to 4 hours from now when resetting password" do
    user = User.new
    user.set_password_reset
    expect(user.expires_at).to be >= Time.now
  end

  it "is valid when a user is created and authenticated in the database" do
    user =User.create(email: "test3@test.com", password: "123", password_confirmation: "123" )
    expect((User.authenticate "test3@test.com", "123").email).to eq user.email
  end
end

