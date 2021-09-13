class SearchController < ApplicationController
  def search
    query = params[:query]

    render :search unless query && !query.empty?

    @posts = Post.where('body LIKE %?%', query)
    @users = User.where('name LIKE %?%', query)
  end
end
