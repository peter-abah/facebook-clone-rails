class SearchController < ApplicationController
  def search
    query = params[:query]

    render :search && return if query.nil? || query.empty?

    query = query.downcase
    @posts = Post.where('LOWER(body) LIKE ?', "%#{query}%").order(updated_at: :desc)
    @users = User.where("LOWER(name) LIKE ? AND id <> #{current_user.id}", "%#{query}%")
  end
end
