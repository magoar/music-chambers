class RoomsController < ApplicationController
  layout "workspace"

  def index
    @festival = Festival.find(params[:festival_id])
    @rooms = Room.where(festival_id: @festival)
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
    @room.festival = @festival
    @room.save
    redirect_to festival_rooms_path(@festival), status: :see_other
  end

  def destroy
    @room = Room.find(params[:id])
    @festival = @room.festival
    @room.destroy
    redirect_to festival_rooms_path(@festival), status: :see_other
  end

  def update
    @room = Room.find(params[:id])
    @room.update(room_params)
    redirect_to festival_rooms_path(@festival)
  end
end

private

def room_params
  params.require(:room).permit(:name, :size)
end
