class MusiciansController < ApplicationController
  layout "workspace"

  def index
    @musicians = Musician.all
    @festival = Festival.find(params[:festival_id])
    @musician = Musician.new
  end

  def create
    @musician = Musician.new(musician_params)
    @festival.user = current_user
    @festival.save
  end

  def destroy
  end

  def update
  end

end
