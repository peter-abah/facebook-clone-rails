class SearchController < ApplicationController
  def search
    query = params[:query]

    render :search && return if query.nil? || query.empty?

    users_sql = "LOWER(CONCAT(first_name, last_name)) LIKE ? AND id <> #{current_user.id}"
    query = query.downcase

    @posts = Post.where('LOWER(body) LIKE ?', "%#{query}%").order(updated_at: :desc)
    @users = User.where(users_sql, "%#{query}%")
  end
end
