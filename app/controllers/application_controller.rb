class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :find_festival

  def find_festival
    @festival = Festival.find_by(id: params[:festival_id])
  end

  def after_sign_in_path_for(_resource)
    festivals_path
  end
end
