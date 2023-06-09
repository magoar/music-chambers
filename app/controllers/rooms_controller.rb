class RoomsController < ApplicationController
  layout "workspace"

  def index
    @festival = Festival.find(params[:festival_id])
    @rooms = @festival.rooms.ordered
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
    @room.festival = @festival
    if @room.save
      redirect_to festival_rooms_path(@festival), status: :see_other
    else
      @rooms = @festival.rooms # this line instanciates the musicians of a festival again for the render
      render :index, locals: { rooms: @rooms }, status: :unprocessable_entity
    end
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

    respond_to do |format|
      format.html { redirect_to festival_rooms_path(@festival) }
      format.text { render partial: "rooms/room_row", locals: { room: @room }, formats: [:html] }
    end
  end
end

private

def room_params
  params.require(:room).permit(:name, :size, requirement_ids: [])
end
