require 'rails_helper'

RSpec.describe User, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"

  let(:user1) { User.create!(name: 'John', email: 'john@email.com', password: '123456', password_confirmation: '123456') }
  let(:user2) { User.create!(name: 'Jane', email: 'jane@email.com', password: '123456', password_confirmation: '123456') }
  let(:user3) { User.create!(name: 'Doe', email: 'doe@email.com', password: '123456', password_confirmation: '123456') }

  describe '#friends' do
    it 'should return friends of user' do
      Friendship.create(user_id: user1.id, friend_id: user2.id)
      Friendship.create(user_id: user3.id, friend_id: user1.id)

      expect(user1.friends).to eq([user2, user3])
    end
  end

  describe '#accept_request' do
    it 'should create a mutual friendship' do
      friend_request = FriendRequest.create!(sender_id: user2.id, receiver_id: user1.id)
      user1.accept_request(friend_request)

      expect(user1.friends).to include(user2)
      expect(user2.friends).to include(user1)
    end
  end

  describe '#remove_friend' do
    it 'should stop users from being mutual friends' do
      Friendship.create(user_id: user1.id, friend_id: user2.id)

      user1.remove_friend(user2)
      expect(user1.friends).not_to include(user2)
      expect(user2.friends).not_to include(user1)
    end
  end
end
