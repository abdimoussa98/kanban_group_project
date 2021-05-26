# == Schema Information
#
# Table name: boards
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  project_id :bigint
#  user_id    :bigint
#
# Indexes
#
#  index_boards_on_project_id  (project_id)
#  index_boards_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (project_id => projects.id)
#  fk_rails_...  (user_id => users.id)
#
class Board < ApplicationRecord

    # Has many association with Project
    belongs_to(
        :project, 
        class_name: 'Project',
        foreign_key: 'project_id',
        inverse_of: :boards
    )

    # Has many association with user for manager association
    belongs_to(
        :user,
        class_name: 'User',
        foreign_key: 'user_id',
        inverse_of: :boards
    )

    # Has many association with Categories
    has_many(
        :categories, 
        class_name: 'Category',
        foreign_key: 'board_id',
        inverse_of: :board,
        dependent: :destroy
    )

    # Many to many association with user for board privleges
    
    has_many :board_assignments, dependent: :destroy
    has_many :assigned_users, :through => :board_assignments, :source => :user

    has_many :board_can_edit_assignements, dependent: :destroy
    has_many :can_edit_users, :through => :board_can_edit_assignements, :source => :user

    has_many :board_can_delete_assignements, dependent: :destroy
    has_many :can_delete_users, :through => :board_can_delete_assignements, :source => :user

    has_many :board_can_assign_users_assignements, dependent: :destroy
    has_many :can_assign_users, :through => :board_can_assign_users_assignements, :source => :user

    has_many :board_can_remove_users_assignements, dependent: :destroy
    has_many :can_remove_users, :through => :board_can_remove_users_assignements, :source => :user
end
