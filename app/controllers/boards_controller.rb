class BoardsController < ApplicationController
   
  before_action :authenticate_user!
  before_action :require_assignment, only: [:show]
  before_action :require_permission_edit_or_update, only: [:edit, :update]
  before_action :require_permission_destroy, only: [:destroy]
  before_action :require_permission_assign_users, only: [:add_user_to_boards]
  before_action :require_permission_remove_users, only: [:remove_users_from_board]
  before_action :require_permission_to_assign_and_revoke_permissions, only: [:add_users_to_can_edit_boards, :remove_users_from_can_edit_boards, :add_users_to_can_assign_users_to_boards, :remove_users_from_can_assign_users_to_boards, :add_users_to_can_remove_users_from_boards, :remove_users_from_can_remove_users_from_boards, :add_users_to_can_delete_boards, :remove_users_from_can_delete_boards]
  
  def index
      @project = Project.find(params[:project_id])
      @boards = @project.boards
      render :index
  end


  def show
      @project = Project.find(params[:project_id])
      @board = @project.boards.find(params[:id])
      @categories = Category.all
      @users = User.all
      render :show
  end

  def new
      @project = Project.find(params[:project_id])
      @board  = Board.new
      render :new
  end

  def create
      @project = Project.find(params[:project_id])
      @board = @project.boards.build(params.require(:board).permit(:name))
      @board.user_id = current_user.id
      if @board.save
        flash[:success] = "New board successfully created!"
        redirect_to project_url(@project)
      else
        flash.now[:error] = "New board creation failed"
        render :new
      end
  end
    
  def edit
      @project = Project.find(params[:project_id])
      @board = Board.find(params[:id])
      render :edit
  end
  
  def update
      @project = Project.find(params[:project_id])
      @board = Board.find(params[:board_id])
      if @board.update(params.require(:board).permit(:name))
        flash[:success] = "Board successfully updated!"
        redirect_to project_url(@project)
      else
        flash.now[:error] = "Board update failed"
        render :edit
      end
  end
###########
def add_user_to_boards
  @project = Project.find(params[:project_id])
  @board = Board.find(params[:id])
  @users = User.all
  @user = @users.find(params[:user_id])
  if @board.assigned_users.where(:id => @user.id).blank?
    @board.assigned_users << @user
    flash[:success] = "User successfully added to board!"
    redirect_to board_url(@project, @board)
  else
      flash[:error] = "Could not add user to board"
      redirect_to board_url(@project, @board)
  end
end

def remove_users_from_board
  @project = Project.find(params[:project_id])
  @board = Board.find(params[:id])
  @user = @board.assigned_users.find(params[:user_id])
  if (@board.user_id != @user.id || current_user.is_admin == true)
    @board.assigned_users.delete(@user)
    flash[:success] = "User successfully removed from board!"
    redirect_to board_url(@project, @board)
    else
      flash[:error] = "Could not remove user from board"
      redirect_to board_url(@project, @board)
    end
    
end

  def destroy
      @project = Project.find(params[:project_id])
      @board = Board.find(params[:id])
      @board.destroy
      flash[:success] = "Board successfully deleted!"
      redirect_to project_path(@project)
  end

  def require_assignment 
    @project = Project.find(params[:project_id])
    @board = Board.find(params[:id])
    if !@board.assigned_users.include?(current_user)  && !current_user.is_admin && @board.user != current_user
      redirect_to project_path(@project), flash: { error: "You do not have permission to do that." }
    end
end
  # Requires permission to perform edit, assign users, remove users, update, and destroy tasks if the current user is not the creator of the project and they are not an admin either
  def require_permission_edit_or_update
    @project = Project.find(params[:project_id])
    @board = Board.find(params[:id])
      if @board.can_edit_users.where(:id => current_user.id).blank? && current_user.is_admin == false
          redirect_to project_path(@project), flash: { error: "You do not have permission to do that." }
      end
  end
  def require_permission_destroy
    @project = Project.find(params[:project_id])
    @board = Board.find(params[:id])
      if @board.can_delete_users.where(:id => current_user.id).blank? && current_user.is_admin == false
          redirect_to project_path(@project), flash: { error: "You do not have permission to do that." }
      end
  end
  def require_permission_assign_users
    @project = Project.find(params[:project_id])
    @board = Board.find(params[:id])
      if @board.can_assign_users.where(:id => current_user.id).blank? && current_user.is_admin == false
        redirect_to board_url(@project, @board), flash: { error: "You do not have permission to do that." }
      end
  end
  def require_permission_remove_users
    @project = Project.find(params[:project_id])
    @board = Board.find(params[:id])
      if @board.can_remove_users.where(:id => current_user.id).blank? && current_user.is_admin == false
        redirect_to board_url(@project, @board), flash: { error: "You do not have permission to do that." }
      end
  end
  def require_permission_to_assign_and_revoke_permissions
    @project = Project.find(params[:project_id])
    @board = Board.find(params[:id])
      if @board.user != current_user && current_user.is_admin == false
        redirect_to board_url(@project, @board), flash: { error: "You do not have permission to do that." }
      end
  end
 
    # PERMISSIONS
  def add_users_to_can_edit_boards
    @project = Project.find(params[:project_id])
    @board = Board.find(params[:id])
    @users = User.all
    @user = @users.find(params[:user_id])
    if @board.can_edit_users.where(:id => @user.id).blank?
      @board.can_edit_users << @user
      flash[:success] = "User successfully given permission to edit board!"
      redirect_to board_url(@project, @board)
    else
        flash[:error] = "Could not give permission"
        redirect_to board_url(@project, @board)
    end
  end

  def remove_users_from_can_edit_boards
    @project = Project.find(params[:project_id])
    @board = Board.find(params[:id])
    @user = @board.can_edit_users.find(params[:user_id])
    if (@board.user_id != @user.id || current_user.is_admin == true)
      @board.can_edit_users.delete(@user)
      flash[:success] = "User successfully has permission to edit boards revoked!"
      redirect_to board_url(@project, @board)
      else
        flash[:error] = "Could not revoke permission"
        redirect_to board_url(@project, @board)
      end
      
  end

  def transfer_manager_of_boards
    @board = Board.find(params[:id])
    @users = User.all
    @user = @users.find(params[:user_id])
    if (current_user.is_admin == true || current_user == @board.user)
      @board.user = @user
      @board.save
      flash[:success] = "User successfully now transferred to be the manager of the board!"
      redirect_to board_url(@board)
    else
      flash.now[:error] = "Could not transfer manager position of board"
      render :show
    end
  end

  def add_users_to_can_delete_boards
    @project = Project.find(params[:project_id])
    @board = Board.find(params[:id])
    @users = User.all
    @user = @users.find(params[:user_id])
    if @board.can_delete_users.where(:id => @user.id).blank?
      @board.can_delete_users << @user
      flash[:success] = "User successfully given permission to delete boards!"
      redirect_to board_url(@project, @board)
    else
        flash[:error] = "Could not give permission"
        redirect_to board_url(@project, @board)
    end
  end

  def remove_users_from_can_delete_boards
    @project = Project.find(params[:project_id])
    @board = Board.find(params[:id])
    @user = @board.can_delete_users.find(params[:user_id])
    if (@board.user_id != @user.id || current_user.is_admin == true)
      @board.can_delete_users.delete(@user)
      flash[:success] = "User successfully has permission to delete boards revoked!"
      redirect_to board_url(@project, @board)
      else
        flash[:error] = "Could not revoke permission"
        redirect_to board_url(@project, @board)
      end
      
  end

  def add_users_to_can_assign_users_to_boards
    @project = Project.find(params[:project_id])
    @board = Board.find(params[:id])
    @users = User.all
    @user = @users.find(params[:user_id])
    if @board.can_assign_users.where(:id => @user.id).blank?
      @board.can_assign_users << @user
      flash[:success] = "User successfully given permission to assign users to boards!"
      redirect_to board_url(@project, @board)
    else
        flash[:error] = "Could not give permission"
        redirect_to board_url(@project, @board)
    end
  end

  def remove_users_from_can_assign_users_to_boards
    @project = Project.find(params[:project_id])
    @board = Board.find(params[:id])
    @user = @board.can_assign_users.find(params[:user_id])
    if (@board.user_id != @user.id || current_user.is_admin == true)
      @board.can_assign_users.delete(@user)
      flash[:success] = "User successfully has permission to assign users to boards revoked!"
      redirect_to board_url(@project, @board)
      else
        flash[:error] = "Could not revoke permission"
        redirect_to board_url(@project, @board)
      end
      
  end

  def add_users_to_can_remove_users_from_boards
    @project = Project.find(params[:project_id])
    @board = Board.find(params[:id])
    @users = User.all
    @user = @users.find(params[:user_id])
    if @board.can_remove_users.where(:id => @user.id).blank?
      @board.can_remove_users << @user
      flash[:success] = "User successfully given permission to remove users to boards!"
      redirect_to board_url(@project, @board)
    else
        flash[:error] = "Could not give permission"
        redirect_to board_url(@project, @board)
    end
  end

  def remove_users_from_can_remove_users_from_boards
    @project = Project.find(params[:project_id])
    @board = Board.find(params[:id])
    @user = @board.can_remove_users.find(params[:user_id])
    if (@board.user_id != @user.id || current_user.is_admin == true)
      @board.can_remove_users.delete(@user)
      flash[:success] = "User successfully has permission to remove users to boards revoked!"
      redirect_to board_url(@project, @board)
      else
        flash[:error] = "Could not revoke permission"
        redirect_to board_url(@project, @board)
      end
      
  end

  
  
end
