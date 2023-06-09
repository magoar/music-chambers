class FestivalsController < ApplicationController
  before_action :find_festival, only: [:show, :destroy, :update]

  def index
    @festivals = Festival.all
    @festival = Festival.new
  end

  def create
    @festival = Festival.new(festival_params)
    @festival.user = current_user
    @festival.save
    redirect_to festivals_path(@festival)
  end

  def destroy
    @festival = Festival.find(params[:id])
    @festival.destroy
    # No need for app/views/restaurants/destroy.html.erb
    redirect_to festivals_path, status: :see_other
  end

  def show
    render layout: "workspace"
  end

  def update
  end

  private

  def find_festival
    @festival = Festival.find(params[:id])
  end

  def festival_params
    params.require(:festival).permit(:name, :id, :start_date, :end_date, :location, :slots_per_day)
  end
end
