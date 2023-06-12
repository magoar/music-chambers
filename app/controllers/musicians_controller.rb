class MusiciansController < ApplicationController
  layout "workspace"

  def index
    @festival = Festival.find(params[:festival_id])
    # @musicians = @festival.musicians
    @musicians = @festival.musicians.ordered
    @musician = Musician.new
  end

  def create
    @musician = Musician.new(musician_params)
    @musician.festival = @festival
    if @musician.save
      redirect_to festival_musicians_path(@festival), status: :see_other
    else
      @musicians = @festival.musicians # this line instanciates the musicians of a festival again for the render
      render :index, locals: { musicians: @musicians }, status: :unprocessable_entity
    end
  end

  def destroy
    @musician = Musician.find(params[:id])
    @festival = @musician.festival
    @musician.destroy
    redirect_to festival_musicians_path(@festival), status: :see_other
  end

  # redirect_to festival_musicians_path(@festival)
  def update
    @musician = Musician.find(params[:id])
    @musician.update(musician_params)

    respond_to do |format|
      format.html { redirect_to festival_musicians_path }
      format.text { render partial: "musicians/musician_row", locals: { musician: @musician }, formats: [:html] }
    end
  end
end

private

def musician_params
  params.require(:musician).permit(:name, :instrument, requirement_ids: [])
end
