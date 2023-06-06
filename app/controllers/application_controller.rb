class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :find_festival

  def find_festival
    @festival = Festival.find_by(id: params[:festival_id])
  end
end
