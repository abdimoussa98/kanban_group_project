class CommentsController < ApplicationController
    before_action :require_ownership, only: [:edit, :delete]
    
    def create
        task = Task.find(params[:task_id])
        comment = task.comments.build(params.require(:comment).permit(:comment))
        comment.user = current_user
        if comment.save
            flash[:success] = "Comment posted!"
            redirect_to show_task_url(task)
        else
            flash.now[:error] = "Error submitting comment!"
            redirect_back
        end
    end

    def delete
        comment = Comment.find(params[:comment_id])
        comment.destroy
        flash[:success] = "Comment removed!"
        redirect_to show_task_url(comment.task)
    end

    
      
    def edit
        @comment = Comment.find(params[:comment_id])
        @task = @comment.task
        render :edit
    end

    def update
        @comment = Comment.find(params[:comment_id])
        @task = @comment.task
        if @comment.update(params.require(:comment).permit(:comment))
          flash[:success] = "comment successfully updated!"
          redirect_to show_task_url(@task)
        else
          flash.now[:error] = "comment update failed"
          render :edit
        end
    end
    def require_ownership
        @comment = Comment.find(params[:comment_id])
        @task = @comment.task
        if @comment.user != current_user  && !current_user.is_admin
            redirect_to show_task_url(@task), flash: { error: "You do not have permission to do that." }
        end
    end
end
