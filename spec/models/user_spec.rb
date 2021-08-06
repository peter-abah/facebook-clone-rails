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

  describe '#add_friend' do
    it 'should create a mutual friendship' do
      friend_request = FriendRequest.create!(sender_id: user2.id, receiver_id: user1.id)
      user1.add_friend(friend_request)
      expect(user1.friends).to include(user2)
      expect(user2.friends).to include(user1)
    end
  end
end
