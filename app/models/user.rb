class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true

  has_many :sent_friend_requests, class_name: 'FriendRequest',
                                  foreign_key: :sender_id, dependent: :destroy
  has_many :received_friend_requests, class_name: 'FriendRequest',
                                      foreign_key: :receiver_id,
                                      dependent: :destroy

  has_many :friendships, dependent: :destroy
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: :friend_id,
                                 dependent: :destroy

  has_many :likes
  has_many :posts, -> { order(updated_at: :desc) }
  has_many :comments
  has_one_attached :profile_picture
  has_one_attached :cover_image

  def all_posts
    friends_posts = friends.reduce([]) { |post_arr, friend| post_arr.concat(friend.posts) }
    posts_for_user = friends_posts + posts

    posts_for_user.sort do |post_a, post_b|
      post_b.updated_at <=> post_a.updated_at
    end
  end

  def friend?(user)
    friends.include?(user)
  end

  def sent_request?(friend)
    sent_friend_requests.exists?(receiver_id: friend.id) || received_friend_requests.exists?(sender_id: friend.id)
  end

  def friend_requests
    sent_friend_requests + recieved_friend_requests
  end

  def friends
    friendships.map(&:friend) + inverse_friendships.map(&:user)
  end

  def friend_request_for_user(user)
    sent_friend_requests.find_by(receiver_id: user.id) || received_friend_requests.find_by(sender_id: user.id)
  end

  def send_request(user)
    sent_friend_requests.create!(receiver_id: user.id) unless sent_request?(user)
  end

  def accept_request(friend_request)
    friendships.create!(friend_id: friend_request.sender_id) unless friend?(friend)
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

  def profile_picture
    super.attached? ? super : 'default_profile_image'
  end

  def cover_image
    super.attached ? super : 'default_cover_image'
  end
end
