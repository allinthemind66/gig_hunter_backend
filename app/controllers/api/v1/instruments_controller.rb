module Api
  module V1
    class InstrumentsController < ApplicationController
      skip_before_action :authorized
      def index
        render json: Instrument.all
      end

      def show
        @instrument = Instrument.all.find(params[:id])
        render json: @instrument
      end

      def new

      end

      def create

      end
    end
  end
end
