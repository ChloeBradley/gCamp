class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end


  def show
    @tasks = Task.find(params[:id])
  end

    def destroy
      task= Task.find(params[:id])
      task.destroy
      redirect_to tasks_path
    end

    def create
      @tasks = Task.new(params[:id])
    end

    def new
      @tasks = Task.new
    end


  private

  def tasks_params
    params.require(:tasks).permit([])
  end
end
