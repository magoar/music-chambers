class MusiciansController < ApplicationController
  layout "workspace"

  def index
    @musicians = Musician.all
    @festival = Festival.find(params[:festival_id])
    @musician = Musician.new
  end

  def create
    @musician = Musician.new(musician_params)
    @musician.festival = @festival
    @musician.save
    redirect_to festival_musicians_path(@festival), status: :see_other
  end

  def destroy
    @musician = Musician.find(params[:id])
    @festival = @musician.festival
    @musician.destroy
    redirect_to festival_musicians_path(@festival), status: :see_other
  end

  def update
    @musician = Musician.find(params[:id])
    @musician.update(musician_params)
    redirect_to festival_musicians_path(@festival)
  end

end

private

def musician_params
  params.require(:musician).permit(:name, :instrument)
end
