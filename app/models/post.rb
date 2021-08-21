class Post < ApplicationRecord
  belongs_to :user

  has_many :likes
  has_many :comments

  has_many_attached :images

  def time
    ApplicationController.helpers.distance_of_time_in_words(updated_at, Time.zone.now)
  end
end
