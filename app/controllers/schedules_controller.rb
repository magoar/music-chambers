class SchedulesController < ApplicationController
  layout "workspace"
  def index
    @festival = Festival.find(params[:festival_id])
  end
end
