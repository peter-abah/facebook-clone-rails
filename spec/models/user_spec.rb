require 'rails_helper'

RSpec.describe User, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"

  describe '#friends' do
    it 'should return friends of user' do
      user1 = User.create!(name: 'John', email: 'john@email.com', password: '123456',
                           password_confirmation: '123456')
      user2 = User.create!(name: 'Jane', email: 'jane@email.com', password: '123456',
                           password_confirmation: '123456')
      user3 = User.create!(name: 'Doe', email: 'doe@email.com', password: '123456',
                           password_confirmation: '123456')

      Friendship.create(user_id: user1.id, friend_id: user2.id)
      Friendship.create(user_id: user3.id, friend_id: user1.id)

      expect(user1.friends).to eq([user2, user3])
    end
  end
end
