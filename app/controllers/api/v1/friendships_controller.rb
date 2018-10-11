class Api::V1::FriendshipsController < ApplicationController
skip_before_action :authorized
  def index
    #
    @friendships = Friendship.all.select{|friendship| friendship.user_id === current_user.id || friendship.friend_id === current_user.id}
    friends = []
    @friendships.select do |friendship|
      friendship.user_id === current_user.id ? friends << User.all.find(friendship.friend_id) : friends << User.all.find(friendship.user_id)
    end
    render json: friends
  end

  def create
    #
    @friendship = Friendship.find_or_create_by(friend_id: params[:id], user_id: current_user.id)
    @friend_request = FriendRequest.find_by(user_id: params[:id], friend_id: current_user.id)
    @friend_request.delete
    @friend = User.all.find(params[:id])
    render json: @friend
  end





    # @friendship = Friendship.find_or_create_by(friend_id: => params[:friendId], user_id: current_user.id)
    # render json: @friendship
end









#     @friendship = current_user.friendships.build(:friend_id => params[:friend_id])
#   if @friendship.save
#     flash[:notice] = "Added friend."
#     redirect_to root_url
#   else
#     flash[:notice] = "Unable to add friend."
#     redirect_to root_url
#   end
# end
