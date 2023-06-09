class GroupsController < ApplicationController
  layout "workspace"

  def index
    @groups = @festival.groups
    @group = Group.new
    @musicians = @festival.musicians
  end

  def create
    @group = Group.new(group_params)
    @group.festival = @festival
    @group.save
    redirect_to festival_groups_path(@festival), status: :see_other
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
    params.require(:group).permit(:name, musician_ids: [])
  end
end
