class TimeslotsController < ApplicationController
  def index

  end

  def create
    @timeslot = Timeslot.new(timeslot_params)
    @timeslot.festival = @festival
    @timeslot.save
    redirect_to festival_path(@festival)
  end

  def update

  end

end

private

def timeslot_params
  params.require(:timeslot).permit(:start_time, :end_time)

end
