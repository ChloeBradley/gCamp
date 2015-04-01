class CommentsController < ApplicationController

  before_action do
    @task = Task.find(params[:task_id])
  end

  

    def create
      @comment = @task.comments.new(comment_params)
      @comment.user_id = current_user.id
      if @comment.save
        redirect_to project_task_path(@task[:project_id], @task[:id])
      else
        redirect_to project_task_path(@task[:project_id], @task[:id])
      end
    end


  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:text, :user_id, :task_id)
  end

   def find_user
     @user = User.find(current_user)
   end



end
