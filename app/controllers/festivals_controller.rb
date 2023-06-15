class FestivalsController < ApplicationController
  before_action :find_festival, only: [:show, :destroy, :update]

  def index
    @festivals = current_user.festivals.ordered
    @festival = Festival.new
  end

  def create
    @festivals = current_user.festivals
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
    @festival = Festival.find(params[:id])
    @festival.update(festival_params)
    redirect_to festival_path, status: :see_other
  end

  def pdf
    respond_to do |format|
      format.html
      format.pdf do
        html = render_to_string(template: 'schedules/index', locals: { festival: @festival })
        send_data Grover.new(html).to_pdf, filename: "#{@festival.name}.pdf", type: "application/pdf"
      end
    end
    # html = render_to_string(template: 'schedules/index.html.erb', locals: { festival: @festival })
    # pdf = Grover.new(html).to_pdf
    # send_data pdf, filename: 'your_file_name.pdf', type: 'application/pdf', disposition: 'attachment'
  end

  private

  def find_festival
    @festival = Festival.find(params[:id])
  end

  def festival_params
    params.require(:festival).permit(:name, :id, :start_date, :end_date, :location, :rehearsals_per_group, :photo)
  end
end
