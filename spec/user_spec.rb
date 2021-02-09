require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'should create a user' do
      user = User.new(
        first_name: "Dipper",
        last_name: "Pines",
        email: "dipper@gmail.com",
        password: "dipper123",
        password_confirmation: "dipper123"
      )
      expect(user).to be_valid
    end

    it 'should not create a user when password_confirmation is different' do
      user = User.new(
        first_name: "Dipper",
        last_name: "Pines",
        email: "dipper@gmail.com",
        password: "dipper123",
        password_confirmation: "dipper"
      )
      expect(user).to_not be_valid
    end

    it 'should not work if password is less than the required # of characters' do
      user = User.new(
        first_name: "Dipper",
        last_name: "Pines",
        email: "dipper@gmail.com",
        password: "dip123",
        password_confirmation: "dip123"
      )
      expect(user).to_not be_valid
    end

    it 'should not save if email already exists in the database' do
      user = User.create(
        first_name: "Dipper",
        last_name: "Pines",
        email: "dipper@gmail.com",
        password: "dipper123",
        password_confirmation: "dipper123"
      )

      user2 = User.create(
        first_name: "Danny",
        last_name: "Phantom",
        email: "DiPPer@gmail.com",
        password: "danny123",
        password_confirmation: "danny123"
      )
      expect(user2).to_not be_valid
    end

    it "should not create user if email is blank" do
      user = User.new(
        first_name: "Dipper",
        last_name: "Pines",
        email: nil,
        password: "dipper123",
        password_confirmation: "dipper123"
      )
      expect(user).not_to be_valid
      puts user.errors.full_messages
    end
  end

  describe '.authenticate_with_credentials' do

    it 'should authenticate a user if email and password match' do
      user = User.new(
        first_name: "Dipper",
        last_name: "Pines",
        email: "dipper@gmail.com",
        password: "dipper123",
        password_confirmation: "dipper123"
      )
      user.save!
      expect(user).to eql(User.authenticate_with_credentials('dipper@gmail.com', 'dipper123'))
    end

    it 'should authenticate a user if email contains trailing spaces' do
      user = User.new(
        first_name: "Dipper",
        last_name: "Pines",
        email: "dipper@gmail.com",
        password: "dipper123",
        password_confirmation: "dipper123"
      )
      user.save!
      expect(user).to eql(User.authenticate_with_credentials(' dipper@gmail.com ', 'dipper123'))
    end

    it 'should authenticate a user if email has capital letters' do
      user = User.new(
        first_name: "Dipper",
        last_name: "Pines",
        email: "dipper@gmail.com",
        password: "dipper123",
        password_confirmation: "dipper123"
      )
      user.save!
      expect(user).to eql(User.authenticate_with_credentials('DiPPer@gmAil.com', 'dipper123'))
    end

    it 'should not authenticate if email is not in database' do
      user = User.authenticate_with_credentials("doctoralbert@gmail.com", "hunter22222")
      expect(user).to be_nil
    end

    it 'should not authenticate if wrong password' do
      user = User.new(
        first_name: "Dipper",
        last_name: "Pines",
        email: "dipper@gmail.com",
        password: "dipper123",
        password_confirmation: "dipper123"
      )
      user.save!
      auth_user = User.authenticate_with_credentials("dipper@gmail.com", "dipper12345")
      expect(auth_user).to be_nil
    end
  end
end 