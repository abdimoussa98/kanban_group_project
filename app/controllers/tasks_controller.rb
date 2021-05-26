class TasksController < ApplicationController
    before_action :authenticate_user!
    before_action :require_category_permission, only: [:new, :create]
    before_action :require_task_permission, only: [:transfer_tasks_to_diff_category]
    before_action :require_permission_edit_or_update, only: [:edit, :update]
    before_action :require_permission_destroy, only: [:delete]
    before_action :require_permission_assign_users, only: [:add_user_to_task]
    before_action :require_permission_remove_users, only: [:remove_users_from_task]
    before_action :require_permission_to_assign_and_revoke_permissions, only: [:add_users_to_can_edit_tasks, :remove_users_from_can_edit_tasks, :add_users_to_can_assign_users_to_tasks, :remove_users_from_can_assign_users_to_tasks, :add_users_to_can_remove_users_from_tasks, :remove_users_from_can_remove_users_from_tasks, :add_users_to_can_delete_tasks, :remove_users_from_can_delete_tasks]
    before_action :require_assignment, only: [:show]

    def show
        @task = Task.find(params[:task_id])
        @category = @task.category
        @categories = Category.all
        @board = @category.board
        @project = @board.project
        @users = User.all
        render :show
    end


    def new
        @task = Task.new
        @category = Category.find(params[:category_id])
        render :new
    end

    def create
        category = Category.find(params[:category_id])
        task = category.tasks.build(params.require(:task).permit(:name, :description, :estimated_work, :due_date))
        task.user_id = current_user.id
        if task.save
          flash[:success] = "New task successfully created!"
          redirect_to show_category_url(category)
        else
          flash.now[:error] = "New task creation failed"
          render :new
        end
    end

    def delete
        task = Task.find(params[:task_id])
        category = task.category
        board = category.board
        project = board.project
        task.destroy
        flash[:success] = "Task successfully deleted!"
        redirect_to board_path(project, board)
    end

    def edit
        @task = Task.find(params[:task_id])
        render :edit
    end

    def update
        task = Task.find(params[:task_id])
        category = task.category
        if task.update(params.require(:task).permit(:name, :description, :estimated_work, :due_date))
            flash[:success] = "Task successfully updated!"
            redirect_to show_category_url(category)
        else
            flash.now[:error] = "Task update failed!"
            render :edit
        end
    end
    def transfer_tasks_to_diff_category
      @task = Task.find(params[:task_id])
      @board = @task.category.board
      @project = @board.project
      @category = Category.find(params[:category_id])
      if (current_user.is_admin == true || current_user == @task.user)
        @task.category = @category
        @task.save
        flash[:success] = "Task successfully now transferred the task to new category!"
        redirect_to board_path(@project, @board)
      else
        flash.now[:error] = "Could not transfer task"
        render :show
      end
  end

    def transfer_manager_of_tasks
        @task = Task.find(params[:id])

        @users = User.all
        @user = @users.find(params[:user_id])
        if (current_user.is_admin == true || current_user == @task.user)
          @task.user = @user
          @task.save
          flash[:success] = "User successfully now transferred to be the manager of the task!"
          redirect_to show_task_url(@task)
        else
          flash.now[:error] = "Could not transfer manager position of task"
          render :show
        end
    end

    def add_user_to_task
    
        @task = Task.find(params[:id])
        @users = User.all
        @user = @users.find(params[:user_id])
        if @task.assigned_users.where(:id => @user.id).blank?
          @task.assigned_users << @user
          flash[:success] = "User successfully added to task!"
          redirect_to show_task_url(@task)
        else
            flash[:error] = "Could not add user to task."
            redirect_to show_task_url(@task)
        end
      end

      def remove_users_from_task
    
        @task = Task.find(params[:id])
        @user = @task.assigned_users.find(params[:user_id])
        if (@task.user_id != @user.id || current_user.is_admin == true)
          @task.assigned_users.delete(@user)
          flash[:success] = "User successfully removed from board!"
          redirect_to show_task_url(@task)
          else
            flash[:error] = "Could not remove user from board"
            redirect_to show_task_url(@task)
          end
          
      end
      
   

    def require_category_permission
        category = Category.find(params[:category_id])
        board = category.board
        project = board.project
        if category.user != current_user && !current_user.is_admin
            redirect_to board_path(project, board), flash: { error: "You do not have permission to do that." }
        end
    end

    def require_task_permission
        task = Task.find(params[:task_id])
        board = task.category.board
        project = board.project
        if task.user != current_user && !current_user.is_admin
            redirect_to board_path(project, board), flash: { error: "You do not have permission to do that." }
        end
    end

    def require_assignment
        task = Task.find(params[:task_id])
        board = task.category.board
        project = board.project
        if !task.assigned_users.include?(current_user)  && !current_user.is_admin && task.user != current_user
            redirect_to board_path(project, board), flash: { error: "You do not have permission to do that." }
        end
    end
    
    #requirements
    def require_permission_edit_or_update
        @task = Task.find(params[:task_id])
        @category = @task.category
        @board = @category.board
        @project = @board.project
          if @task.can_edit_users.where(:id => current_user.id).blank? && current_user.is_admin == false
              redirect_to show_category_url(@category), flash: { error: "You do not have permission to do that." }
          end
      end
      def require_permission_destroy
        @task = Task.find(params[:task_id])
        @category = @task.category
        @board = @category.board
        @project = @board.project
          if @task.can_delete_users.where(:id => current_user.id).blank? && current_user.is_admin == false
              redirect_to show_category_url(@category), flash: { error: "You do not have permission to do that." }
          end
      end
      def require_permission_assign_users
        @task = Task.find(params[:task_id])
        @category = @task.category
        @board = @category.board
        @project = @board.project
          if @task.can_assign_users.where(:id => current_user.id).blank? && current_user.is_admin == false
            redirect_to show_task_url(@task), flash: { error: "You do not have permission to do that." }
          end
      end
      def require_permission_remove_users
        @task = Task.find(params[:task_id])
        @category = @task.category
        @board = @category.board
        @project = @board.project
          if @task.can_remove_users.where(:id => current_user.id).blank? && current_user.is_admin == false
            redirect_to show_task_url(@task), flash: { error: "You do not have permission to do that." }
          end
      end
      def require_permission_to_assign_and_revoke_permissions
        @task = Task.find(params[:task_id])
        @category = @task.category
        @board = @category.board
        @project = @board.project
          if @task.user != current_user && current_user.is_admin == false
            redirect_to show_task_url(@task), flash: { error: "You do not have permission to do that." }
          end
      end



    # PERMISSIONS
def add_users_to_can_edit_tasks
    @task = Task.find(params[:task_id])
    @category = @task.category
    @board = @category.board
    @project = @board.project
    @users = User.all
    @user = @users.find(params[:user_id])
    if @task.can_edit_users.where(:id => @user.id).blank?
      @task.can_edit_users << @user
      flash[:success] = "User successfully given permission to edit task!"
      redirect_to show_task_url(@task)
    else
        flash[:error] = "Could not give permission"
        redirect_to show_task_url(@task)
    end
  end

  def remove_users_from_can_edit_tasks
    @task = Task.find(params[:task_id])
    @category = @task.category
    @board = @category.board
    @project = @board.project
    @user = @task.can_edit_users.find(params[:user_id])
    if (@task.user_id != @user.id || current_user.is_admin == true)
      @task.can_edit_users.delete(@user)
      flash[:success] = "User successfully has permission to edit tasks revoked!"
      redirect_to show_task_url(@task)
      else
        flash[:error] = "Could not revoke permission"
        redirect_to show_task_url(@task)
      end
      
  end

  def transfer_manager_of_tasks
    @task = task.find(params[:id])
    @users = User.all
    @user = @users.find(params[:user_id])
    if (current_user.is_admin == true || current_user == @task.user)
      @task.user = @user
      @task.save
      flash[:success] = "User successfully now transferred to be the manager of the task!"
      redirect_to task_url(@task)
    else
      flash.now[:error] = "Could not transfer manager position of task"
      render :show
    end
  end

  def add_users_to_can_delete_tasks
    @task = Task.find(params[:task_id])
    @category = @task.category
    @board = @category.board
    @project = @board.project
    @users = User.all
    @user = @users.find(params[:user_id])
    if @task.can_delete_users.where(:id => @user.id).blank?
      @task.can_delete_users << @user
      flash[:success] = "User successfully given permission to delete tasks!"
      redirect_to show_task_url(@task)
    else
        flash[:error] = "Could not give permission"
        redirect_to show_task_url(@task)
    end
  end

  def remove_users_from_can_delete_tasks
    @task = Task.find(params[:task_id])
    @category = @task.category
    @board = @category.board
    @project = @board.project
    @user = @task.can_delete_users.find(params[:user_id])
    if (@task.user_id != @user.id || current_user.is_admin == true)
      @task.can_delete_users.delete(@user)
      flash[:success] = "User successfully has permission to delete tasks revoked!"
      redirect_to show_task_url(@task)
      else
        flash[:error] = "Could not revoke permission"
        redirect_to show_task_url(@task)
      end
      
  end

  def add_users_to_can_assign_users_to_tasks
    @task = Task.find(params[:task_id])
    @category = @task.category
    @board = @category.board
    @project = @board.project
    @users = User.all
    @user = @users.find(params[:user_id])
    if @task.can_assign_users.where(:id => @user.id).blank?
      @task.can_assign_users << @user
      flash[:success] = "User successfully given permission to assign users to tasks!"
      redirect_to show_task_url(@task)
    else
        flash[:error] = "Could not give permission"
        redirect_to show_task_url(@task)
    end
  end

  def remove_users_from_can_assign_users_to_tasks
    @task = Task.find(params[:task_id])
    @category = @task.category
    @board = @category.board
    @project = @board.project
    @user = @task.can_assign_users.find(params[:user_id])
    if (@task.user_id != @user.id || current_user.is_admin == true)
      @task.can_assign_users.delete(@user)
      flash[:success] = "User successfully has permission to assign users to tasks revoked!"
      redirect_to show_task_url(@task)
      else
        flash[:error] = "Could not revoke permission"
        redirect_to show_task_url(@task)
      end
      
  end

  def add_users_to_can_remove_users_from_tasks
    @task = Task.find(params[:task_id])
    @category = @task.category
    @board = @category.board
    @project = @board.project
    @users = User.all
    @user = @users.find(params[:user_id])
    if @task.can_remove_users.where(:id => @user.id).blank?
      @task.can_remove_users << @user
      flash[:success] = "User successfully given permission to remove users to tasks!"
      redirect_to show_task_url(@task)
    else
        flash[:error] = "Could not give permission"
        redirect_to show_task_url(@task)
    end
  end

  def remove_users_from_can_remove_users_from_tasks
    @task = Task.find(params[:task_id])
    @category = @task.category
    @board = @category.board
    @project = @board.project
    @user = @task.can_remove_users.find(params[:user_id])
    if (@task.user_id != @user.id || current_user.is_admin == true)
      @task.can_remove_users.delete(@user)
      flash[:success] = "User successfully has permission to remove users to tasks revoked!"
      redirect_to show_task_url(@task)
      else
        flash[:error] = "Could not revoke permission"
        redirect_to show_task_url(@task)
      end
      
  end
























end
