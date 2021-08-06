class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :sent_friend_requests, class_name: 'FriendRequest',
                                  foreign_key: :sender_id, dependent: :destroy
  has_many :recieved_friend_requests, class_name: 'FriendRequest',
                                      foreign_key: :receiver_id,
                                      dependent: :destroy

  has_many :friendships
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: :friend_id

  def friends
    friendships.map(&:friend) + inverse_friendships.map(&:user)
  end
end
