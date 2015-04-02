class ProjectsController < ApplicationController
  before_action :authenticate_user
  before_action :project_member, only: [:edit, :show, :destroy, :update]
  before_action :project_owner, only: [:edit, :destroy, :update]


  def index
    if current_user.tracker_token || current_user.admin?
       tracker_api = TrackerAPI.new
       @tracker_projects = tracker_api.projects(current_user.tracker_token)
     end
    if current_user.admin?
      @projects = Project.all
    else
      @projects = current_user.projects
    end
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
       @project.memberships.create(user_id: current_user.id, role: "Owner")
      flash[:success] = "Project was successfully created"
      redirect_to project_tasks_path(@project)
    else
      render :new
    end
  end

  def show
    @project = Project.find(params[:id])
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
      if @project.update(project_params)
        flash[:success] = "Project was successfully updated!"
        redirect_to project_path(@project)
      else
        render :edit
      end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    redirect_to projects_path, success: "Project was successfully deleted"
  end


  private

  def project_params
    params.require(:project).permit(:name)
  end
end
