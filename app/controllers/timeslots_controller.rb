class TimeslotsController < ApplicationController
  layout "workspace"

  def index
    @festival = Festival.find(params[:festival_id])
    @timeslots = @festival.timeslots
    @timeslot = Timeslot.new
  end

  def create
    @timeslot = Timeslot.new(timeslot_params)
    @timeslot.festival = @festival
    if @timeslot.save
      redirect_to festival_timeslots_path(@festival)
    else
      @timeslots = @festival.timeslots
      render :index, locals: { timeslots: @timeslots }, status: :unprocessable_entity
    end
  end

  def update
    @timeslot = Timeslot.find(params[:id])
    @timeslot.update(timeslot_params)

    respond_to do |format|
      format.html { redirect_to festival_timeslots_path }
      format.text { render partial: "timeslots/timeslot_row", locals: { timeslot: @timeslot }, formats: [:html] }
    end
  end

  def destroy
    @timeslot = Timeslot.find(params[:id])
    @festival = @timeslot.festival
    @timeslot.destroy
    redirect_to festival_timeslots_path(@festival), status: :see_other
  end

  private

  def timeslot_params
    params.require(:timeslot).permit(:start_time, :end_time)
  end
end
