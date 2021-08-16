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

  describe '#all_posts' do
    it 'should return all posts of user and friends' do
      Friendship.create(user_id: user1.id, friend_id: user2.id)

      post1 = user1.posts.create(body: 'First post')
      post2 = user2.posts.create(body: 'Second post')
      user3.posts.create(body: 'Third post')

      expect(user1.all_posts).to eq([post1, post2])
    end
  end

  describe '#liked_post?' do
    let(:post) { user1.posts.create!(body: 'filler') }
    before do
      post.likes.create!(user_id: user2.id)
    end

    it 'should return false if user has not liked post' do
      result = user1.liked_post?(post)
      expect(result).to be_falsey
    end

    it 'should return true if user has liked post' do
      result = user2.liked_post?(post)
      expect(result).to be_truthy
    end
  end

  describe '#like_for_post' do
    it 'should return like for post' do
      post = user1.posts.create!(body: 'filler')
      post.likes.create!(user_id: user2.id)
      
      like = user2.like_for_post(post)
      expect(like.user_id).to eq user2.id
    end
  end
end
