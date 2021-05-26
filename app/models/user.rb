# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  is_admin               :boolean
#  name                   :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # Has many association with comments
  has_many(
    :comments,
    class_name: 'Comment',
    foreign_key: 'user_id',
    inverse_of: :user,
    dependent: :destroy
  )
  
  # Has many association with project for manager association
  has_many(
    :projects,
    class_name: 'Project',
    foreign_key: 'project_id',
    inverse_of: :user,
    dependent: :destroy
  )

  # Has many association with boards for manager association
  has_many(
    :boards,
    class_name: 'Board',
    foreign_key: 'board_id',
    inverse_of: :user,
    dependent: :destroy
  )

  # Has many association with categories for manager association
  has_many(
    :categories, 
    class_name: 'Category',
    foreign_key: 'category_id',
    inverse_of: :user, 
    dependent: :destroy
  )

  # Has many association with tasks for manager association
  has_many(
    :tasks,
    class_name: 'Task',
    foreign_key: 'task_id',
    inverse_of: :user, 
    dependent: :destroy
  )

  # Many to many association with Project for Project privleges

  has_many :project_assignements, dependent: :destroy
  has_many :projects_assigned, through: :project_assignements

  has_many :project_can_edit_assignements, dependent: :destroy
  has_many :can_edit_projects, through: :project_can_edit_assignements

  has_many :project_can_delete_assignements, dependent: :destroy
  has_many :can_delete_projects, through: :project_can_delete_assignements

  has_many :project_can_assign_users_assignements, dependent: :destroy
  has_many :can_assign_projects, through: :project_can_assign_users_assignements

  has_many :project_can_remove_users_assignements, dependent: :destroy
  has_many :can_remove_projects, through: :project_can_remove_users_assignements


  # Many to many association with Board for board privleges

  has_many :board_assignments, dependent: :destroy
  has_many :boards_assigned, through: :board_assignments

  has_many :board_can_edit_assignements, dependent: :destroy
  has_many :can_edit_boards, through: :board_can_edit_assignements

  has_many :board_can_delete_assignements, dependent: :destroy
  has_many :can_delete_boards, through: :board_can_delete_assignements

  has_many :board_can_assign_users_assignements, dependent: :destroy
  has_many :can_assign_boards, through: :board_can_assign_users_assignements

  has_many :board_can_remove_users_assignements, dependent: :destroy
  has_many :can_remove_boards, through: :board_can_remove_users_assignements

  # Many to many association with category for category privleges

  has_many :category_assignments, dependent: :destroy
  has_many :categories_assigned, through: :category_assignments

  has_many :category_can_edit_assignements, dependent: :destroy
  has_many :can_edit_categories, through: :category_can_edit_assignements

  has_many :category_can_delete_assignements, dependent: :destroy
  has_many :can_delete_categories, through: :category_can_delete_assignements

  has_many :category_can_assign_users_assignements, dependent: :destroy
  has_many :can_assign_categories, through: :category_can_assign_users_assignements

  has_many :category_can_remove_users_assignements, dependent: :destroy
  has_many :can_remove_categories, through: :category_can_remove_users_assignements

  # Many to many association with task for task privleges

  has_many :task_assignments, dependent: :destroy
  has_many :tasks_assigned, through: :task_assignments

  has_many :task_can_edit_assignements, dependent: :destroy
  has_many :can_edit_tasks, through: :task_can_edit_assignements

  has_many :task_can_delete_assignements, dependent: :destroy
  has_many :can_delete_tasks, through: :task_can_delete_assignements

  has_many :task_can_assign_users_assignements, dependent: :destroy
  has_many :can_assign_tasks, through: :task_can_assign_users_assignements

  has_many :task_can_remove_users_assignements, dependent: :destroy
  has_many :can_remove_tasks, through: :task_can_remove_users_assignements


end
