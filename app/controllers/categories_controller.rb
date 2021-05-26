class CategoriesController < ApplicationController
    before_action :authenticate_user!
    before_action :require_board_permission, only: [:new, :create]
    before_action :require_permission_destroy, only: [:destroy]
    before_action :require_permission_edit_or_update, only: [:edit, :update]
    before_action :require_permission_assign_users, only: [:add_user_to_category]
    before_action :require_permission_remove_users, only: [:remove_users_from_category]
    before_action :require_assignment, only: [:show]
    before_action :require_permission_to_assign_and_revoke_permissions, only: [:add_users_to_can_edit_categories, :remove_users_from_can_edit_categories, :add_users_to_can_assign_users_to_categories, :remove_users_from_can_assign_users_to_categories, :add_users_to_can_remove_users_from_categories, :remove_users_from_can_remove_users_from_categories, :add_users_to_can_delete_categories, :remove_users_from_can_delete_categories]

    def show
        @category = Category.find(params[:category_id])
        @board = @category.board
        @project = @board.project 
        @users = User.all
        render :show
    end

    def new
        @board = Board.find(params[:board_id])
        @project = @board.project
        @category = Category.new
        render :new
    end

    def create
        @project = Project.find(params[:project_id])
        @board = @project.boards.find(params[:board_id])
        @category = @board.categories.build(params.require(:category).permit(:name))
        @category.user_id = current_user.id
        if @category.save
          flash[:success] = "New category successfully created!"
          redirect_to board_url(@project, @board)
        else
          flash.now[:error] = "New category creation failed"
          render :new
        end
    end

    def edit
        @category = Category.find(params[:category_id])
        @board = @category.board
        @project = @board.project
        render :edit
    end

    def update
        @project = Project.find(params[:project_id])
        @board = @project.boards.find(params[:board_id])
        @category = @board.categories.find(params[:category_id])
        if @category.update(params.require(:category).permit(:name))
            flash[:success] = "Category successfully updated!"
            redirect_to board_url(@project, @board)
        else
            flash.now[:error] = "Category update failed!"
            render :edit
        end
    end

    def destroy
        category = Category.find(params[:category_id])
        board = category.board
        project = board.project
        category.destroy
        flash[:success] = "Category successfully deleted!"
        redirect_to board_path(project, board)
    end

    def transfer_manager_of_cats
        @category = Category.find(params[:id])
        @users = User.all
        @user = @users.find(params[:user_id])
        if (current_user.is_admin == true || current_user == @category.user)
          @category.user = @user
          @category.save
          flash[:success] = "User successfully now transferred to be the manager of the category!"
          redirect_to show_category_url(@category)
        else
          flash.now[:error] = "Could not transfer manager position of category"
          render :show
        end
    end

    def add_user_to_category

        @category = Category.find(params[:id])
        @users = User.all
        @user = @users.find(params[:user_id])
        if @category.assigned_users.where(:id => @user.id).blank?
          @category.assigned_users << @user
          flash[:success] = "User successfully added to category!"
          redirect_to show_category_url(@category)
        else
            flash[:error] = "Could not add user to category."
            redirect_to show_category_url(@category)
        end
      end

      def remove_users_from_category

        @category = Category.find(params[:id])
        @user = @category.assigned_users.find(params[:user_id])
        if (@category.user_id != @user.id || current_user.is_admin == true)
          @category.assigned_users.delete(@user)
          flash[:success] = "User successfully removed from category!"
          redirect_to show_category_url(@category)
          else
            flash[:error] = "Could not remove user from category."
            redirect_to show_task_url(@category)
          end

      end

      

    def require_category_permission
        category = Category.find(params[:category_id])
        board = category.board
        project = board.project
        if Category.find(params[:category_id]).user != current_user && !current_user.is_admin
            redirect_to board_path(project, board), flash: { error: "You do not have permission to do that." }
        end
    end

    def require_board_permission
        board = Board.find(params[:board_id])
        project = board.project
        if board.user != current_user && !current_user.is_admin
            redirect_to board_path(project, board), flash: { error: "You do not have permission to do that." }
        end
    end


    def require_assignment
        category = Category.find(params[:category_id])
        board = category.board
        project = board.project
        if !category.assigned_users.include?(current_user)  && !current_user.is_admin && category.user != current_user
            redirect_to board_path(project, board), flash: { error: "You do not have permission to do that." }
        end
    end

    ##requirements
    def require_permission_edit_or_update
        @category = Category.find(params[:category_id])
        @board = @category.board
        @project = @board.project    
          if @category.can_edit_users.where(:id => current_user.id).blank? && current_user.is_admin == false
              redirect_to board_url(@project, @board), flash: { error: "You do not have permission to do that." }
          end
      end
    def require_permission_destroy
        @category = Category.find(params[:category_id])
        @board = @category.board
        @project = @board.project    
          if @category.can_delete_users.where(:id => current_user.id).blank? && current_user.is_admin == false
              redirect_to board_url(@project, @board), flash: { error: "You do not have permission to do that." }
          end
      end
    def require_permission_assign_users
        @category = Category.find(params[:category_id])
        @board = @category.board
        @project = @board.project    
          if @category.can_assign_users.where(:id => current_user.id).blank? && current_user.is_admin == false
            redirect_to show_category_url(@category), flash: { error: "You do not have permission to do that." }
          end
      end
    def require_permission_remove_users
        @category = Category.find(params[:category_id])
        @board = @category.board
        @project = @board.project    
          if @category.can_remove_users.where(:id => current_user.id).blank? && current_user.is_admin == false
            redirect_to show_category_url(@category), flash: { error: "You do not have permission to do that." }
          end
      end
    def require_permission_to_assign_and_revoke_permissions
        @category = Category.find(params[:category_id])
        @board = @category.board
        @project = @board.project
          if @category.user != current_user && current_user.is_admin == false
            redirect_to show_category_url(@category), flash: { error: "You do not have permission to do that." }
          end
      end

     # PERMISSIONS
    def add_users_to_can_edit_categories
        @category = Category.find(params[:category_id])
        @board = @category.board
        @project = @board.project
        @users = User.all
        @user = @users.find(params[:user_id])
        if @category.can_edit_users.where(:id => @user.id).blank?
        @category.can_edit_users << @user
        flash[:success] = "User successfully given permission to edit category!"
        redirect_to show_category_url(@category)
        else
            flash[:error] = "Could not give permission"
            redirect_to show_category_url(@category)
        end
    end

    def remove_users_from_can_edit_categories
        @category = Category.find(params[:category_id])
        @board = @category.board
        @project = @board.project
        @user = @category.can_edit_users.find(params[:user_id])
        if (@category.user_id != @user.id || current_user.is_admin == true)
        @category.can_edit_users.delete(@user)
        flash[:success] = "User successfully has permission to edit categories revoked!"
        redirect_to show_category_url(@category)
        else
            flash[:error] = "Could not revoke permission"
            redirect_to show_category_url(@category)
        end
        
    end

    def add_users_to_can_delete_categories
        @category = Category.find(params[:category_id])
        @board = @category.board
        @project = @board.project
        @users = User.all
        @user = @users.find(params[:user_id])
        if @category.can_delete_users.where(:id => @user.id).blank?
        @category.can_delete_users << @user
        flash[:success] = "User successfully given permission to delete categories!"
        redirect_to show_category_url(@category)
        else
            flash[:error] = "Could not give permission"
            redirect_to show_category_url(@category)
        end
    end

    def remove_users_from_can_delete_categories
        @category = Category.find(params[:category_id])
        @board = @category.board
        @project = @board.project
        @user = @category.can_delete_users.find(params[:user_id])
        if (@category.user_id != @user.id || current_user.is_admin == true)
        @category.can_delete_users.delete(@user)
        flash[:success] = "User successfully has permission to delete categories revoked!"
        redirect_to show_category_url(@category)
        else
            flash[:error] = "Could not revoke permission"
            redirect_to show_category_url(@category)
        end
        
    end

    def add_users_to_can_assign_users_to_categories
        @category = Category.find(params[:category_id])
        @board = @category.board
        @project = @board.project
        @users = User.all
        @user = @users.find(params[:user_id])
        if @category.can_assign_users.where(:id => @user.id).blank?
        @category.can_assign_users << @user
        flash[:success] = "User successfully given permission to assign users to categories!"
        redirect_to show_category_url(@category)
        else
            flash[:error] = "Could not give permission"
            redirect_to show_category_url(@category)
        end
    end

    def remove_users_from_can_assign_users_to_categories
        @category = Category.find(params[:category_id])
        @board = @category.board
        @project = @board.project
        @user = @category.can_assign_users.find(params[:user_id])
        if (@category.user_id != @user.id || current_user.is_admin == true)
        @category.can_assign_users.delete(@user)
        flash[:success] = "User successfully has permission to assign users to categories revoked!"
        redirect_to show_category_url(@category)
        else
            flash[:error] = "Could not revoke permission"
            redirect_to show_category_url(@category)
        end
        
    end

    def add_users_to_can_remove_users_from_categories
        @category = Category.find(params[:category_id])
        @board = @category.board
        @project = @board.project
        @users = User.all
        @user = @users.find(params[:user_id])
        if @category.can_remove_users.where(:id => @user.id).blank?
        @category.can_remove_users << @user
        flash[:success] = "User successfully given permission to remove users to categories!"
        redirect_to show_category_url(@category)
        else
            flash[:error] = "Could not give permission"
            redirect_to show_category_url(@category)
        end
    end

    def remove_users_from_can_remove_users_from_categories
        @category = Category.find(params[:category_id])
        @board = @category.board
        @project = @board.project
        @user = @category.can_remove_users.find(params[:user_id])
        if (@category.user_id != @user.id || current_user.is_admin == true)
        @category.can_remove_users.delete(@user)
        flash[:success] = "User successfully has permission to remove users to categories revoked!"
        redirect_to show_category_url(@category)
        else
            flash[:error] = "Could not revoke permission"
            redirect_to show_category_url(@category)
        end
        
    end


end
