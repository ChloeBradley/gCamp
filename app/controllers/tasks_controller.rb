class TasksController < ApplicationController


  before_action do
    @project = Project.find(params[:project_id])
  end

  before_action :authenticate_user
  before_action :project_member_permission

  def index
    @tasks = @project.tasks
  end

  def new
  @task = Task.new
  end


  def show
    @task = Task.find(params[:id])
    @comment = Comment.new
    @comments = @task.comments
  end

  def edit
     @task = Task.find(params[:id])
  end


  def create
    @task = @project.tasks.new(task_params)
    if @task.save
      flash[:success] = "Task was successfully created!"
       redirect_to project_task_path(@project, @task)
    else
      render :new
    end
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      flash[:success] = "Task was successfully updated!"
      redirect_to project_task_path
    else
      render :edit
    end
  end


  def destroy
    Task.find(params[:id]).destroy
    flash[:success] = "Task was successfully deleted."
    redirect_to project_tasks_path(@project)
  end

  def project_member_permission
    project = Project.find(params[:project_id])
    unless current_user.admin || current_user.is_project_member(project)
      flash[:danger] = "You do not have access to that project"
      redirect_to projects_path
    end
  end


  private

  def task_params
    params.require(:task).permit(:description, :complete, :due_date)
  end

end
