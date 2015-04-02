class MembershipsController < ApplicationController
  before_action do
    @project = Project.find(params[:project_id])
  end
  before_action :member_or_admin_auth, except: [:destroy]
  before_action :set_membership, only: [:update, :destroy]
  before_action :ensure_user_is_not_the_last_owner, only: [:update, :destroy]
  before_action :find_member, only: [:update, :destroy]
  before_action :find_user_for_now
  before_action :verify_owner_access, only: [:update, :destroy]


  def index
    @membership = @project.memberships.new
  end

  def create
    @membership = @project.memberships.new(membership_params)
    if @membership.save
      flash[:success] = "#{@membership.user.full_name} was successfully added"
      redirect_to project_memberships_path
    else
      render :index
    end
  end

  def update
    if @membership.update(membership_params)
      flash[:success] = "#{@membership.user.full_name} was successfully updated"
      redirect_to project_memberships_path
    end
  end

  def destroy
    @membership.destroy
    flash[:success] = "#{@membership.user.full_name} was successfully removed"

    redirect_to project_memberships_path
  end

  private

    def membership_params
      params.require(:membership).permit(:role, :project_id, :user_id)
    end

    def find_member
      @current_member = current_user.memberships.find_by(project_id: @project.id)
      unless @current_member.role == "Owner" || @project.memberships.pluck(:user_id).include?(current_user.id)
        flash[:danger] = "You do not have access"
        redirect_to project_path(@project)
      end
    end

   def cannot_delete_without_permissions
     unless @project.memberships.where(user_id: current_user.id) || current_user.admin
       flash[:danger] = 'You do not have access'
       redirect_to projects_path
     end
   end


   def find_user_for_now
     @current_member = current_user.memberships.find_by(project_id: @project.id)
   end

   def set_membership
     @membership = @project.memberships.find(params[:id])
   end

  def ensure_user_is_not_the_last_owner
    if current_user.is_project_owner(@project) && @project.memberships.where(role: 'Owner').count <= 1 && @membership.role == 'Owner'
      flash[:danger] = 'Projects must have at least one owner'
      redirect_to project_memberships_path(@project)
    end
  end

  def verify_owner_access
    if @project.memberships.pluck(:user_id).include?(current_user.id)
      flash[:danger] = 'You do not have access'
      redirect_to projects_path
    end
  end

  def member_or_admin_auth
     unless (current_user.is_project_member(@project) || current_user.admin)
       flash[:danger] = 'You do not have access to that project'
       redirect_to projects_path
     end
   end
end
