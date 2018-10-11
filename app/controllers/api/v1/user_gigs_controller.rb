module Api
  module V1
    class UserGigsController < ApplicationController
      skip_before_action :authorized
      def index
        render json: UserGig.all
      end

      def show
        @user = UserGig.find(params[:id])
        render json: @user, include: ['instruments', 'gigs']
      end

      def new

      end

      def create
        @user = User.all.find(params[:userId])
        @gig = Gig.all.find(params[:gigId])
        @user_gig = UserGig.find_or_create_by(user_id: @user.id, gig_id: @gig.id)
        gig_app_to_delete = @gig.gig_applications.find{|gig_app| gig_app.user_id === @user.id}
        gig_app_to_delete.delete
        render json: @user
      end

      def edit

      end

      def update

      end

      def destroy

        @user_gig = UserGig.find_by(gig_id: params[:gigId], user_id: params[:userId])
        @user_gig.delete
        render json: UserGig.all
      end

    end
  end
end
