require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do

    it 'is valid with valid attributes' do
      user = User.new(
        first_name: 'John',
        last_name: 'Doe',
        email: 'john.doe@example.com',
        password: 'password',
        password_confirmation: 'password'
      )
      expect(user).to be_valid
    end

    it 'is not valid without a password' do
      user = User.new(password: nil)
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("Password can't be blank")
    end

    it 'is not valid without a password_confirmation' do
      user = User.new(password: 'password', password_confirmation: nil)
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("Password confirmation can't be blank")
    end

    it 'is not valid when password and password_confirmation do not match' do
      user = User.new(password: 'password', password_confirmation: 'different')
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'is not valid if the password is shorter than 6 characters' do
      user = User.new(password: 'pass', password_confirmation: 'pass')

      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end

    it 'is not valid without an email' do
      user = User.new(email: nil)
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("Email can't be blank")
    end

    it 'is not valid without a first name' do
      user = User.new(first_name: nil)
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("First name can't be blank")
    end

    it 'is not valid without a last name' do
      user = User.new(last_name: nil)
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("Last name can't be blank")
    end

    it 'is not valid if the email is not unique (case insensitive)' do
      User.create(
        first_name: 'John',
        last_name: 'Doe',
        email: 'test@example.com',
        password: 'password',
        password_confirmation: 'password'
      )

      user = User.new(
        first_name: 'Jane',
        last_name: 'Doe',
        email: 'TEST@EXAMPLE.COM',
        password: 'password',
        password_confirmation: 'password'
      )
      
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("Email has already been taken")
    end
  end

  describe '.authenticate_with_credentials' do
    it 'returns the user if credentials are correct' do
      user = User.create(
        first_name: "Jane",
        last_name: "Doe",
        email: "jane@example.com",
        password: "password",
        password_confirmation: "password"
      )
      authenticated_user = User.authenticate_with_credentials('jane@example.com', 'password')
      expect(authenticated_user).to eq(user)
    end

    it 'returns nil if the email is incorrect' do
      User.create(
        first_name: "Jane",
        last_name: "Doe",
        email: "jane@example.com",
        password: "password",
        password_confirmation: "password"
      )
      authenticated_user = User.authenticate_with_credentials('wrong@example.com', 'password')
      expect(authenticated_user).to be_nil
    end

    it 'returns nil if the password is incorrect' do
      User.create(
        first_name: "Jane",
        last_name: "Doe",
        email: "jane@example.com",
        password: "password",
        password_confirmation: "password"
      )
      authenticated_user = User.authenticate_with_credentials('jane@example.com', 'wrongpassword')
      expect(authenticated_user).to be_nil
    end

    it 'authenticates even with leading/trailing spaces in the email' do
      user = User.create(
        first_name: "Jane",
        last_name: "Doe",
        email: "jane@example.com",
        password: "password",
        password_confirmation: "password"
      )
      authenticated_user = User.authenticate_with_credentials('  jane@example.com  ', 'password')
      expect(authenticated_user).to eq(user)
    end

    it 'authenticates even if the email has incorrect casing' do
      user = User.create(
        first_name: "Jane",
        last_name: "Doe",
        email: "jane@example.com",
        password: "password",
        password_confirmation: "password"
      )
      authenticated_user = User.authenticate_with_credentials('JANE@EXAMPLE.COM', 'password')
      expect(authenticated_user).to eq(user)
    end

    it 'authenticates with leading/trailing spaces in the email' do
      user = User.create(
        first_name: "Jane",
        last_name: "Doe",
        email: "jane@example.com",
        password: "password",
        password_confirmation: "password"
      )
      authenticated_user = User.authenticate_with_credentials('  jane@example.com  ', 'password')
      expect(authenticated_user).to eq(user)
    end
  
    it 'authenticates with incorrect casing in the email' do
      user = User.create(
        first_name: "Jane",
        last_name: "Doe",
        email: "jane@example.com",
        password: "password",
        password_confirmation: "password"
      )
      authenticated_user = User.authenticate_with_credentials('jAnE@EXAMPLE.COM', 'password')
      expect(authenticated_user).to eq(user)
    end
  end
end
