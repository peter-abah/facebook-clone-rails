class UsersController < ApplicationController
  def friends
    @friends = current_user.friends
    @received_friend_requests = current_user.received_friend_requests
    @sent_friend_requests = current_user.sent_friend_requests
  end
end
