# == Schema Information
#
# Table name: categories
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  board_id   :bigint
#  user_id    :bigint
#
# Indexes
#
#  index_categories_on_board_id  (board_id)
#  index_categories_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (board_id => boards.id)
#  fk_rails_...  (user_id => users.id)
#
class Category < ApplicationRecord

    # Has many association with board
    belongs_to(
        :board,
        class_name: 'Board',
        foreign_key: 'board_id',
        inverse_of: :categories
    )

    # Has many association with user for manager association
    belongs_to(
        :user,
        class_name: 'User',
        foreign_key: 'user_id',
        inverse_of: :categories
    )

    # Has many association with task
    has_many(
        :tasks, 
        class_name: 'Task',
        foreign_key: 'category_id',
        inverse_of: :category, 
        dependent: :destroy
    )

    # Many to Many association with user for categoryprivleges

    has_many :category_assignments, dependent: :destroy
    has_many :assigned_users, :through => :category_assignments, :source => :user

    has_many :category_can_edit_assignements, dependent: :destroy
    has_many :can_edit_users, :through => :category_can_edit_assignements, :source => :user

    has_many :category_can_delete_assignements, dependent: :destroy
    has_many :can_delete_users, :through => :category_can_delete_assignements, :source => :user

    has_many :category_can_assign_users_assignements, dependent: :destroy
    has_many :can_assign_users, :through => :category_can_assign_users_assignements, :source => :user

    has_many :category_can_remove_users_assignements, dependent: :destroy
    has_many :can_remove_users, :through => :category_can_remove_users_assignements, :source => :user
    
end
