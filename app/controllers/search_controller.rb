class SearchController < ApplicationController
  def search
    query = params[:query]

    render :search && return if query.nil? || query.empty?

    query = query.downcase
    @posts = Post.where('LOWER(body) LIKE ?', "%#{query}%")
    @users = User.where('LOWER(name) LIKE ?', "%#{query}%")
  end
end
