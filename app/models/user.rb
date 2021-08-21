class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true

  has_many :sent_friend_requests, class_name: 'FriendRequest',
                                  foreign_key: :sender_id, dependent: :destroy
  has_many :recieved_friend_requests, class_name: 'FriendRequest',
                                      foreign_key: :receiver_id,
                                      dependent: :destroy

  has_many :friendships, dependent: :destroy
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: :friend_id,
                                 dependent: :destroy

  has_many :likes
  has_many :posts
  has_many :comments

  has_one_attached :profile_picture

  def all_posts
    friends_posts = friends.reduce([]) { |post_arr, friend| post_arr.concat(friend.posts) }
    (friends_posts + posts).sort { |post_a, post_b| post_a.updated_at <=> post_b.updated_at }
  end

  def friends
    friendships.map(&:friend) + inverse_friendships.map(&:user)
  end

  def send_request(user)
    sent_friend_requests.build(receiver_id: user.id)
  end

  def accept_request(friend_request)
    friendships.create!(friend_id: friend_request.sender_id)
    friend_request.destroy
  end

  def delete_request(friend_request)
    raise unless friend_request.sender == self || friend_request.receiver == self

    friend_request.delete
  end

  def remove_friend(friend)
    friendship = friendships.find_by(friend_id: friend.id) || 
                 inverse_friendships.find_by!(user_id: friend.id)
    friendship.destroy
  end

  def liked_post?(post)
    !like_for_post(post).nil?
  end

  def like_for_post(post)
    likes.find_by(post_id: post.id)
  end
end
