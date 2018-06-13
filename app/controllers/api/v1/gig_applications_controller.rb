class Api::V1::GigApplicationsController < ApplicationController
  def index

  end

  def show
    # byebug
  end

  def create
    # byebug
    @gig_application = GigApplication.find_or_create_by(gig_id: params[:gigId], user_id: current_user.id)

    # byebug
    render json: @gig_application
  end

  def delete_gig_application
    @gig_application =  GigApplication.all.find_by(gig_id: params[:gigId], user_id: params[:userId])
    @gig_application.delete
  end
end
