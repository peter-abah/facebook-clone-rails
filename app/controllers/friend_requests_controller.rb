class FriendRequestsController < ApplicationController
  def index
    @received_friend_requests = current_user.received_friend_requests
    @sent_friend_requests = current_user.sent_friend_requests
  end

  def send_request
    friend = User.find(params[:id])
    current_user.send_request(friend)

    redirect_back fallback_location: root_path
  end

  def accept_request
    friend_request = FriendRequest.find(params[:id])
    current_user.accept_request(friend_request)

    redirect_back fallback_location: '/friends'
  end

  def delete_request
    friend_request = FriendRequest.find(params[:id])
    current_user.delete_request(friend_request)

    redirect_back fallback_location: '/friends'
  end
end
