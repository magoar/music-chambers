class GroupsController < ApplicationController
  layout "workspace"

  def index
    @groups = Group.all
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.save
  end

  def destroy
    @group = Group.find(params[:id])
    @festival = @group.festival
    @group.destroy
    redirect_to festival_groups_path(@festival), status: :see_other
  end

  def update
  end

  private

  def group_params
    params.require(:group).permit(:name)
  end
end
