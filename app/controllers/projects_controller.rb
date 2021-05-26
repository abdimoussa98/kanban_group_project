class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_permission_edit_or_update, only: [:edit, :update]
  before_action :require_permission_destroy, only: [:destroy]
  before_action :require_permission_assign_users, only: [:add_user_to_projects]
  before_action :require_permission_remove_users, only: [:remove_users_from_project]
  before_action :require_permission_to_assign_and_revoke_permissions, only: [:add_users_to_can_edit_projects, :remove_users_from_can_edit_projects, :add_users_to_can_assign_users_to_projects, :remove_users_from_can_assign_users_to_projects, :add_users_to_can_remove_users_from_projects, :remove_users_from_can_remove_users_from_projects, :add_users_to_can_delete_projects, :remove_users_from_can_delete_projects]
  before_action :involved_with_project, only: [:show]
  
  # Index includes boards, categories, and tasks so we can access them in index page to find assigned users.
  def index
      @projects = Project.all
      @boards = Board.all
      @categories = Category.all
      @tasks = Task.all
      render :index
  end

  def show
      @project = Project.find(params[:id])
      @users = User.all
      @boards = Board.all
      @categories = Category.all
      render :show
  end
  
  def new
      @project = Project.new
      render :new
  end
  
  def create
      @project = Project.new(params.require(:project).permit(:name))
      @project.user_id = current_user.id
      if @project.save
        flash[:success] = "New project successfully created!"
        redirect_to projects_url
      else
        flash.now[:error] = "New project creation failed"
        render :new
      end
  end
    
  def edit
      @project = Project.find(params[:id])
      render :edit
  end
  
  def update
      @project = Project.find(params[:id])
      if @project.update(params.require(:project).permit(:name))
        flash[:success] = "Project successfully updated!"
        redirect_to projects_url(@project)
      else
        flash.now[:error] = "Project update failed"
        render :edit
      end
  end

  def destroy
      @project = Project.find(params[:id])
      @project.destroy
      flash[:success] = "Project successfully deleted!"
      redirect_to projects_path(@project)
  end

  def add_user_to_projects
    
    @project = Project.find(params[:id])
    @users = User.all
    @user = @users.find(params[:user_id])
    if @project.assigned_users.where(:id => @user.id).blank?
      @project.assigned_users << @user
      flash[:success] = "User successfully added to project!"
      redirect_to project_url(@project)
    else
      flash.now[:error] = "Could not add user to project"
      render :show
    end
  end

  def remove_users_from_project
    @project = Project.find(params[:id])
    @user = @project.assigned_users.find(params[:user_id])
    if (@project.user_id != @user.id || current_user.is_admin == true)
      @project.assigned_users.delete(@user) ##
      flash[:success] = "User successfully removed from project!"
        redirect_to project_url(@project)
      else
        flash[:error] = "Could not remove user from project"
        redirect_to project_url(@project)
      end
      
  end

  def transfer_manager_of_projects
    @project = Project.find(params[:id])
    @users = User.all
    @user = @users.find(params[:user_id])
    if (current_user.is_admin == true || current_user == @project.user)
      @project.user = @user
      @project.save
      flash[:success] = "User successfully now transferred to be the manager of the project!"
      redirect_to project_url(@project)
    else
      flash.now[:error] = "Could not transfer manager position of project"
      render :show
    end
  end

  ##Permissions for edit, delete, and add users similar to board permissions for projects

  def require_permission_edit_or_update
    @project = Project.find(params[:id])
      if @project.can_edit_users.where(:id => current_user.id).blank? && current_user.is_admin == false && @project.user != current_user
          redirect_to projects_path, flash: { error: "You do not have permission to do that." }
      end
  end

  def require_permission_destroy
    @project = Project.find(params[:id])
      if @project.can_delete_users.where(:id => current_user.id).blank? && current_user.is_admin == false && @project.user != current_user
          redirect_to projects_path, flash: { error: "You do not have permission to do that." }
      end
  end

  def require_permission_assign_users
    @project = Project.find(params[:id])
      if @project.can_assign_users.where(:id => current_user.id).blank? && current_user.is_admin == false && @project.user != current_user
        redirect_to project_url(@project), flash: { error: "You do not have permission to do that." }
      end
  end

  def require_permission_remove_users
    @project = Project.find(params[:id])
      if @project.can_remove_users.where(:id => current_user.id).blank? && current_user.is_admin == false && @project.user != current_user
        redirect_to project_url(@project), flash: { error: "You do not have permission to do that." } 
      end
  end

  def require_permission_to_assign_and_revoke_permissions
    @project = Project.find(params[:id])
      if @project.user != current_user && current_user.is_admin == false 
        redirect_to project_url(@project), flash: { error: "You do not have permission to do that." }
      end
  end

  def add_users_to_can_edit_projects
    @project = Project.find(params[:id])
    @users = User.all
    @user = @users.find(params[:user_id])
    if @project.can_edit_users.where(:id => @user.id).blank?
      @project.can_edit_users << @user
      flash[:success] = "User successfully given permission to edit project!"
      redirect_to project_url(@project)
    else
        flash[:error] = "Could not give permission"
        redirect_to project_url(@project)
    end
  end

  def remove_users_from_can_edit_projects
    @project = Project.find(params[:id])
    @user = @project.can_edit_users.find(params[:user_id])
    if (@project.user_id != @user.id || current_user.is_admin == true)
      @project.can_edit_users.delete(@user)
      flash[:success] = "User successfully has permission to edit projects revoked!"
      redirect_to project_url(@project)
      else
        flash[:error] = "Could not revoke permission"
        redirect_to project_url(@project)
      end
      
  end

  def add_users_to_can_delete_projects
    @project = Project.find(params[:id])
    @users = User.all
    @user = @users.find(params[:user_id])
    if @project.can_delete_users.where(:id => @user.id).blank?
      @project.can_delete_users << @user
      flash[:success] = "User successfully given permission to delete projects!"
      redirect_to project_url(@project)
    else
        flash[:error] = "Could not give permission"
        redirect_to project_url(@project)
    end
  end

  def remove_users_from_can_delete_projects
    @project = Project.find(params[:id])
    @user = @project.can_delete_users.find(params[:user_id])
    if (@project.user_id != @user.id || current_user.is_admin == true)
      @project.can_delete_users.delete(@user)
      flash[:success] = "User successfully has permission to delete projects revoked!"
      redirect_to project_url(@project)
      else
        flash[:error] = "Could not revoke permission"
        redirect_to project_url(@project)
      end
      
  end

  def add_users_to_can_assign_users_to_projects
    @project = Project.find(params[:id])
    @users = User.all
    @user = @users.find(params[:user_id])
    if @project.can_assign_users.where(:id => @user.id).blank?
      @project.can_assign_users << @user
      flash[:success] = "User successfully given permission to assign users to projects!"
      redirect_to project_url(@project)
    else
        flash[:error] = "Could not give permission"
        redirect_to project_url(@project)
    end
  end

  def remove_users_from_can_assign_users_to_projects
    @project = Project.find(params[:id])
    @user = @project.can_assign_users.find(params[:user_id])
    if (@project.user_id != @user.id || current_user.is_admin == true)
      @project.can_assign_users.delete(@user)
      flash[:success] = "User successfully has permission to assign users to projects revoked!"
      redirect_to project_url(@project)
      else
        flash[:error] = "Could not revoke permission"
        redirect_to project_url(@project)
      end
      
  end

  def add_users_to_can_remove_users_from_projects
    @project = Project.find(params[:id])
    @users = User.all
    @user = @users.find(params[:user_id])
    if @project.can_remove_users.where(:id => @user.id).blank?
      @project.can_remove_users << @user
      flash[:success] = "User successfully given permission to remove users to projects!"
      redirect_to project_url(@project)
    else
        flash[:error] = "Could not give permission"
        redirect_to project_url(@project)
    end
  end

  def remove_users_from_can_remove_users_from_projects
    @project = Project.find(params[:id])
    @user = @project.can_remove_users.find(params[:user_id])
    if (@project.user_id != @user.id || current_user.is_admin == true)
      @project.can_remove_users.delete(@user)
      flash[:success] = "User successfully has permission to remove users to projects revoked!"
      redirect_to project_url(@project)
      else
        flash[:error] = "Could not revoke permission"
        redirect_to project_url(@project)
      end
  end

  #Allows users to see the project (via the url project id) only if they are somehow involved with the project or its contents
  def involved_with_project
    ids = Array.new([])
    @projects = Project.all
    @project = Project.find(params[:id])
    @boards = Board.all
    @categories = Category.all
    @tasks = Task.all

        @projects.each do |pro|  
              if pro.assigned_users.include?(current_user) || pro.user == current_user || current_user.is_admin == true
                ids << pro.id 
              end
         end 

        @boards.each do |board|
          project = board.project.id
          if board.assigned_users.include?(current_user) || board.user == current_user || current_user.is_admin == true
            ids << project 
          end
        end
        
        @categories.each do |cat|
          project = cat.board.project.id
          if cat.assigned_users.include?(current_user) || cat.user == current_user || current_user.is_admin == true
            ids << project 
          end
        end

        @tasks.each do |task|
          project = task.category.board.project.id
          if task.assigned_users.include?(current_user) || task.user == current_user || current_user.is_admin == true
            ids << project 
          end
        end
        
      #Removes any repetetive projects from project id list
        ids_uniq = ids.uniq
    #redirects the user if they are not involved at all with that project or its contents
    if ids_uniq.include?(@project.id) == false 
      redirect_to projects_path, flash: { error: "You do not have permission to do that." }
    end
  end
end
