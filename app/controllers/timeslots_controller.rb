class TimeslotsController < ApplicationController
  def index

  end

  def new

  end

  def create
    @timeslot = Timeslot.new(timeslot_params)
    @timeslot.festival = @festival
    @timeslot.save
    redirect_to festival_path(@festival)
  end

  def update
    @timeslot = Timeslot.find(params[:id])
    @timeslot.update(timeslot_params)
    redirect_to festival_path(@festival), status: :see_other
  end

  private

  def timeslot_params
    params.require(:timeslot).permit(:start_time, :end_time)
  end
end
