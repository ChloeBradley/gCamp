class MembershipsController < ApplicationController
  before_action do
    @project = Project.find(params[:project_id])
  end
  before_action :find_member, only: [:edit, :update]
  before_action :find_user_for_now
    def index
     @membership = @project.memberships.new
   end

  def edit
    @membership = Membership.find(params[:id])
  end

  def create
    @membership = @project.memberships.new(membership_params)
    if @membership.save
    flash[:success] = "#{@membership.user.full_name} was successfully created"
    redirect_to project_memberships_path
    else
      render :index
  end
end

  def update
    @membership = Membership.find(params[:id])
    if @membership.update(membership_params)
      flash[:success] = "#{@membership.user.full_name} was successfully updated"
      redirect_to project_memberships_path
    end
  end

  def destroy
    membership = @project.memberships.find(params[:id])
    membership.destroy
    flash[:success] = "#{membership.user.full_name} was successfully removed"
    redirect_to project_memberships_path
  end

  private

    def membership_params
      params.require(:membership).permit(:role, :project_id, :user_id)
    end

    def find_member
     @current_member = current_user.memberships.find_by(project_id: @project.id)
     if @current_member.role == "Owner"

     else
       flash[:danger] = "You do not have access"
       redirect_to project_path(@project)
     end
   end

   def find_user_for_now
     @current_member = current_user.memberships.find_by(project_id: @project.id)
   end

end
