class FestivalsController < ApplicationController
  def index
  end

  def new
  end

  def create
  end

  def destroy
  end

  def show
    render layout: "workspace"
  end

  def update
  end

  private

  def find_festival
    @festival = Festival.find(params[:id])
  end
end
