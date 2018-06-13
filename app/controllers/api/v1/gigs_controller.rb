  class Api::V1::GigsController < ApplicationController
      skip_before_action :authorized
      def index
        # byebug
        render json: Gig.all
      end

      def show
        @gig = Gig.find(params[:id])
        # render json: @user, include: ['instruments', 'gigs']
        render json: @gig, include: ['users', 'user', 'gig_applications']
      end

      def new

      end

      def create
        @gig = Gig.new(gigs_params)
        @gig.user_id = current_user.id
        @gig.save
        render json: Gig.all
      end

      def update
        @gig = Gig.all.find(params[:id])
        @gig.update(gigs_params)
        render json: @gig
      end

      def all_applicants
        @gig = Gig.all.find(params[:id])
        @gig_users = []
        @gig.gig_applications.each{|app| @gig_users << app.user}
        render json: @gig_users
      end

      def signed_in_user_gigs
        @gigs = Gig.all
        token = params[:token]
        user_id = JWT.decode(token, ENV["SECRET"], true, { algorithm: ENV["ALG"] })[0]["user_id"]
        @filteredApplicationGigs = @gigs.all.select do |gig|
          !gig.gig_applications.detect do |app|
            app.user_id == user_id
          end
        end.select do |gig|
          !gig.users.detect do |user_gig|
            user_gig.id == user_id
          end
        end
        render json: @filteredApplicationGigs
      end

      private
      def gigs_params
        params.require(:gig).permit(:venue, :location, :style, :time, :description, :date, :group, :pay, :rehearsals, :concert_dress)
      end
end
