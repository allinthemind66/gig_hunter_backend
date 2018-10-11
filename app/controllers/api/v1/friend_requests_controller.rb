class Api::V1::FriendRequestsController < ApplicationController
  skip_before_action :authorized

  def index
    #friend id is the id on the person another person is tring to friend.
    token =  request.headers["Authorization"].split(" ")[1]
    #
    id = JWT.decode(token, ENV["SECRET"], true, { algorithm: ENV["ALG"] })[0]["user_id"]
    @friend_requests = FriendRequest.all.select{|fr| fr.friend_id === id }
    #
    users = []
    @friend_requests.each{|request| users << User.all.find(request[:user_id])}

    render json: users
  end

  def create
    puts 'this is the current user'
    puts current_user
    puts 'these are the params'
    puts params
    puts 'these are the headers'
    puts request.headers
    puts 'this is the authorization header'
    puts request.headers["Authorization"]
    @friendRequest = FriendRequest.find_or_create_by(friend_id: params[:friendId], user_id: current_user.id)
    render json: @friendRequest
  end


end
