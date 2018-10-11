class Api::V1::GigApplicationsController < ApplicationController
  skip_before_action :authorized
  def index

  end

  def show
    #
  end

  def create
    #
    @gig_application = GigApplication.find_or_create_by(gig_id: params[:gigId], user_id: current_user.id)

    #
    render json: @gig_application
  end

  def delete_gig_application
    @gig_application =  GigApplication.all.find_by(gig_id: params[:gigId], user_id: params[:userId])
    @gig_application.delete
  end
end
