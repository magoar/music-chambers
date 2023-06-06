class FestivalsController < ApplicationController
  def index
    @festivals = Festival.all
  end

  def new
    @festival = Festival.new
  end

  def create
  end

  def destroy
  end

  def show
  end

  def update
  end
end
