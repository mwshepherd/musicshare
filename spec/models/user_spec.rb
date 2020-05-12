require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(email: 'test@test.com', password: '123456', fullname: 'Test User', username: 'test_User', bio: 'a description about the test user goes here', is_admin: nil)}
  context 'validation' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a username' do
      subject.username = nil
      expect(subject).to_not be_valid
    end
  end
end
