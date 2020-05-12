require 'rails_helper'

RSpec.describe Listing, type: :model do
  let (:user) { User.new(email: 'test@test.com', password: '123456', fullname: 'Test User', username: 'test_User', bio: 'a description about the test user goes here', is_admin: nil) }
  subject { Listing.new(title: 'Vintage synthesizer', price: 1000, description: '80s analog synth', user: user) }
  context 'validation' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a title' do
      subject.title = nil
      expect(subject).to_not be_valid
    end

    it 'is valid with a title up to 100 characters' do
      subject.title = 'a' * 100
      expect(subject).to be_valid
    end

    it 'is not valid with a title greater than 100 characters' do
      subject.title = 'a' * 101
      expect(subject).to_not be_valid
    end

    it 'is valid with a price greater than zero' do
      subject.price = 1
      expect(subject).to be_valid
    end

    it 'is not valid with a price less than or equal to zero' do
      subject.price = 0
      expect(subject).to_not be_valid
    end

    it 'is not valid without a user' do
      subject.user = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without a description less than 5 characters' do
      subject.description = 'a' * 2
      expect(subject).to_not be_valid
    end
  end
end
