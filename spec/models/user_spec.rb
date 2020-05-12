require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(email: 'test@test.com', password: '123456', fullname: 'Test User', username: 'test_User', bio: 'a description about the test user goes here', is_admin: nil)}
  context 'validation' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a full name' do
      subject.fullname = nil
      expect(subject).to_not be_valid
    end

    it 'is valid with a fullname up to 70 characters' do
      subject.fullname = 'a' * 70
      expect(subject).to be_valid
    end

    it 'is not valid with a fullname greater than 70 characters' do
      subject.fullname = 'a' * 71
      expect(subject).to_not be_valid
    end

    it 'is not valid without a username' do
      subject.username = nil
      expect(subject).to_not be_valid
    end

    it 'is valid with a username up to 15 characters' do
      subject.username = 'a' * 15
      expect(subject).to be_valid
    end

    it 'is not valid with a username greater than 15 characters' do
      subject.username = 'a' * 16
      expect(subject).to_not be_valid
    end

    it 'is not valid without a password' do
      subject.password = nil
      expect(subject).to_not be_valid
    end

    it 'is valid without a bio' do
      subject.bio = nil
      expect(subject).to be_valid
    end

    it 'is not valid with a bio greater than 250 characters' do
      subject.bio = 'a' * 251
      expect(subject).to_not be_valid
    end
  end
end
