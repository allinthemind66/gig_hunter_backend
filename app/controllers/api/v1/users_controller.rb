class Api::V1::UsersController < ApplicationController
  skip_before_action :authorized, only: [:index, :create, :show]

  def index
    @users = User.all
    render json: @users, status: 200
  end

  def show
    @user = User.find(params[:id])
    render json: @user, include: ['instruments','gigs']
  end

  def create
    @user = User.new(user_params)
    @user.password = params[:password]
    @user.img_url = 'https://cdn.filestackcontent.com/ehIcNumRke6Mn1dp6kjA'
    @instrument1 = Instrument.find_or_create_by(name: params[:primaryInstrument])
    @instrument2 = Instrument.find_or_create_by(name: params[:secondaryInstrument])
    @user.instruments << @instrument1
    @user.instruments << @instrument2

    if @user.valid?
      @user.save
      token = encode_token({ user_id: @user.id })
      render json: { id: @user.id, jwt: token }, status: 202
    else
      render json: { message: "#{@user.errors.messages.keys[0]} #{@user.errors[@user.errors.messages.keys[0]][0]}" }, status: 404
    end
  end

  def update
    @user = User.all.find(current_user.id)
    @user.update(name: params[:data][:name], city: params[:data][:city], hometown: params[:data][:hometown], bio: params[:data][:bio])
    # @user.save
    render json: @user
  end

  def add_img

    @user = User.all.find(current_user[:id])
    @user.img_url = params[:img]
    @user.save
    render json: @user
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :city, :name)
  end

end
