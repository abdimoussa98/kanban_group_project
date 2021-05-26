Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root :to => redirect("/users/sign_in")

  # Projects
  get 'projects', to: 'projects#index', as: 'projects'  
  post 'projects', to: 'projects#create'
  get 'projects/new', to: 'projects#new', as: 'new_project'
  get 'projects/:id', to: 'projects#show', as: 'project'
  patch 'projects/:id', to: 'projects#update'
  delete 'projects/:id', to: 'projects#destroy'
  get 'projects/:id/edit', to: 'projects#edit', as: 'edit_project'
  
  post 'projects/:id/add_user', to: 'projects#add_user_to_projects', as: 'add_user_project'
  post 'projects/:id/remove_user', to: 'projects#remove_users_from_project', as: 'remove_user_project'
  post 'projects/:id/transfer_manager', to: 'projects#transfer_manager_of_projects', as: 'transfer_manager'

  #permissions for projects
  post 'projects/:id/add_user_can_edit_project', to: 'projects#add_users_to_can_edit_projects', as: 'add_user_can_edit_project'
  post 'projects/:id/remove_user_can_edit_project', to: 'projects#remove_users_from_can_edit_projects', as: 'remove_user_can_edit_project'

  post 'projects/:id/add_user_can_delete_project', to: 'projects#add_users_to_can_delete_projects', as: 'add_user_can_delete_project'
  post 'projects/:project_id/boards/:id/remove_user_can_delete_project', to: 'projects#remove_users_from_can_delete_projects', as: 'remove_user_can_delete_project'

  post 'projects/:id/add_user_can_assign_users_project', to: 'projects#add_users_to_can_assign_users_to_projects', as: 'add_user_can_assign_users_project'
  post 'projects/:id/remove_user_can_assign_users_project', to: 'projects#remove_users_from_can_assign_users_to_projects', as: 'remove_user_can_assign_users_project'

  post 'projects/:id/add_user_can_remove_users_project', to: 'projects#add_users_to_can_remove_users_from_projects', as: 'add_user_can_remove_users_project'
  post 'projects/:id/remove_user_can_remove_users_project', to: 'projects#remove_users_from_can_remove_users_from_projects', as: 'remove_user_can_remove_users_project'

  # Boards routes
  get 'projects/:project_id/boards', to: 'boards#index', as: 'boards'  
  post 'projects/:project_id/boards', to: 'boards#create'
  get 'projects/:project_id/boards/new', to: 'boards#new', as: 'new_board'
  get 'projects/:project_id/boards/:id', to: 'boards#show', as: 'board'
  patch 'projects/:project_id/boards/:id', to: 'boards#update'  
  delete 'projects/:project_id/boards/:id', to: 'boards#destroy', as: 'delete_board'
  get 'projects/:project_id/boards/:id/edit', to: 'boards#edit', as: 'edit_board'

  post 'projects/:project_id/boards/:id/transfer_manager', to: 'boards#transfer_manager_of_boards', as: 'transfer_manager_board'

  post 'projects/:project_id/boards/:id/add_user_board', to: 'boards#add_user_to_boards', as: 'add_user_board'
  post 'projects/:project_id/boards/:id/remove_user_board', to: 'boards#remove_users_from_board', as: 'remove_user_board'

  #permissions for boards
  post 'projects/:project_id/boards/:id/add_user_can_edit_board', to: 'boards#add_users_to_can_edit_boards', as: 'add_user_can_edit_board'
  post 'projects/:project_id/boards/:id/remove_user_can_edit_board', to: 'boards#remove_users_from_can_edit_boards', as: 'remove_user_can_edit_board'

  post 'projects/:project_id/boards/:id/add_user_can_delete_board', to: 'boards#add_users_to_can_delete_boards', as: 'add_user_can_delete_board'
  post 'projects/:project_id/boards/:id/remove_user_can_delete_board', to: 'boards#remove_users_from_can_delete_boards', as: 'remove_user_can_delete_board'

  post 'projects/:project_id/boards/:id/add_user_can_assign_users_board', to: 'boards#add_users_to_can_assign_users_to_boards', as: 'add_user_can_assign_users_board'
  post 'projects/:project_id/boards/:id/remove_user_can_assign_users_board', to: 'boards#remove_users_from_can_assign_users_to_boards', as: 'remove_user_can_assign_users_board'

  post 'projects/:project_id/boards/:id/add_user_can_remove_users_board', to: 'boards#add_users_to_can_remove_users_from_boards', as: 'add_user_can_remove_users_board'
  post 'projects/:project_id/boards/:id/remove_user_can_remove_users_board', to: 'boards#remove_users_from_can_remove_users_from_boards', as: 'remove_user_can_remove_users_board'


  # Categories routes
  get 'boards/:board_id/categories/new',                                  to: 'categories#new',     as: 'new_category'
  post 'projects/:project_id/boards/:board_id/categories',                to: 'categories#create',  as: 'create_category'
  get 'categories/:category_id/edit',                                     to: 'categories#edit',    as: 'edit_category'
  patch 'projects/:project_id/boards/:board_id/categories/:category_id',  to: 'categories#update',  as: 'update_category'
  delete 'categories/:category_id',                                       to: 'categories#destroy', as: 'delete_category'
  get 'categories/:category_id',                                          to: 'categories#show',    as: 'show_category'
  post 'categories/:category_id/transfer_manager', to: 'categories#transfer_manager_of_cats', as: 'transfer_manager_cat'

  post 'categories/:category_id/add_user', to: 'categories#add_user_to_category', as: 'add_user_category'
  post 'categories/:category_id/remove_user', to: 'categories#remove_users_from_category', as: 'remove_user_category'

  #permissions for categories
  post 'categories/:category_id/add_user_can_edit_category', to: 'categories#add_users_to_can_edit_categories', as: 'add_user_can_edit_category'
  post 'categories/:category_id/remove_user_can_edit_category', to: 'categories#remove_users_from_can_edit_categories', as: 'remove_user_can_edit_category'

  post 'categories/:category_id/add_user_can_delete_category', to: 'categories#add_users_to_can_delete_categories', as: 'add_user_can_delete_category'
  post 'categories/:category_id/remove_user_can_delete_category', to: 'categories#remove_users_from_can_delete_categories', as: 'remove_user_can_delete_category'

  post 'categories/:category_id/add_user_can_assign_users_category', to: 'categories#add_users_to_can_assign_users_to_categories', as: 'add_user_can_assign_users_category'
  post 'categories/:category_id/remove_user_can_assign_users_category', to: 'categories#remove_users_from_can_assign_users_to_categories', as: 'remove_user_can_assign_users_category'

  post 'categories/:category_id/add_user_can_remove_users_category', to: 'categories#add_users_to_can_remove_users_from_categories', as: 'add_user_can_remove_users_category'
  post 'categories/:category_id/remove_user_can_remove_users_category', to: 'categories#remove_users_from_can_remove_users_from_categories', as: 'remove_user_can_remove_users_category'


  # Tasks routes
  get 'categories/:category_id/new',  to: 'tasks#new',      as: 'new_task'
  get 'tasks/:task_id',               to: 'tasks#show',     as: 'show_task'
  post 'categories/:category_id',     to: 'tasks#create',   as: 'create_task'
  delete 'tasks/:task_id',            to: 'tasks#delete',   as: 'delete_task'
  get 'tasks/:task_id/edit',          to: 'tasks#edit',     as: 'edit_task'
  patch 'tasks/:task_id',             to: 'tasks#update',   as: 'update_task'
  post 'tasks/:task_id/transfer_manager', to: 'tasks#transfer_manager_of_tasks', as: 'transfer_manager_task'

  post 'task/:task_id/add_user', to: 'tasks#add_user_to_task', as: 'add_user_task'
  post 'task/:task_id/remove_user', to: 'tasks#remove_users_from_task', as: 'remove_user_task'
  post 'task/:task_id/move_task', to: 'tasks#transfer_tasks_to_diff_category', as: 'move_task'

  #permission for tasks
  post 'task/:task_id/add_user_can_edit_task', to: 'tasks#add_users_to_can_edit_tasks', as: 'add_user_can_edit_task'
  post 'task/:task_id/remove_user_can_edit_task', to: 'tasks#remove_users_from_can_edit_tasks', as: 'remove_user_can_edit_task'

  post 'task/:task_id/add_user_can_delete_task', to: 'tasks#add_users_to_can_delete_tasks', as: 'add_user_can_delete_task'
  post 'task/:task_id/remove_user_can_delete_task', to: 'tasks#remove_users_from_can_delete_tasks', as: 'remove_user_can_delete_task'

  post 'task/:task_id/add_user_can_assign_users_task', to: 'tasks#add_users_to_can_assign_users_to_tasks', as: 'add_user_can_assign_users_task'
  post 'task/:task_id/remove_user_can_assign_users_task', to: 'tasks#remove_users_from_can_assign_users_to_tasks', as: 'remove_user_can_assign_users_task'

  post 'task/:task_id/add_user_can_remove_users_task', to: 'tasks#add_users_to_can_remove_users_from_tasks', as: 'add_user_can_remove_users_task'
  post 'task/:task_id/remove_user_can_remove_users_task', to: 'tasks#remove_users_from_can_remove_users_from_tasks', as: 'remove_user_can_remove_users_task'

  # Comments routes
  post 'tasks/:task_id/comments',     to: 'comments#create',  as: 'create_comment'
  delete 'comments/:comment_id',      to: 'comments#delete',  as: 'delete_comment'
  get 'comments/:comment_id/edit',          to: 'comments#edit',     as: 'edit_comment'
  patch 'comments/:comment_id',         to: 'comments#update',         as: 'update_comment'
end
