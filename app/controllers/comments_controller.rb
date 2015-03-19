class CommentsController < ApplicationController

  before_action do
    @task = Task.find(params[:task_id])
  end

    def create
      @comment = @task.comments.new(comment_params)
      @comment.user_id = current_user.id
      if @comment.save
        # flash[:success] = "Comment was successfully created!"
        redirect_to project_task_path(@task[:project_id], @task)
      else
        render "task/show"
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
