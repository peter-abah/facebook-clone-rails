module PostsHelper
  def post_time(post)
    distance_of_time_in_words(post.updated_at, Time.zone.now)
  end
end
