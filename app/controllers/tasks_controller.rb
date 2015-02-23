class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end


  def show
    @task = Task.find(params[:id])
  end

  def edit
    @task = Task.find(params[:id])
  end

    def destroy
      task= Task.find(params[:id])
      task.destroy
      redirect_to tasks_path
    end

    def create
      @task = Task.new(task_params)
      if @task.save
        flash[:notice] = "Task was successfully created!"
         redirect_to task_path(@task)
      else
        @task= Task.new(task_params)
        render:new
      end
    end

    def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      flash[:notice] = "Task was successfully updated!"
      redirect_to task_path(@task)
    else
      render :edit
    end
  end

    def new
      @task = Task.new
    end


  private

  def task_params
    params.require(:task).permit(:description, :complete, :due_date)
  end
end
