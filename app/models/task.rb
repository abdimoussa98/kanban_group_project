# == Schema Information
#
# Table name: tasks
#
#  id             :bigint           not null, primary key
#  description    :string
#  due_date       :string
#  estimated_work :integer
#  name           :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  category_id    :bigint
#  user_id        :bigint
#
# Indexes
#
#  index_tasks_on_category_id  (category_id)
#  index_tasks_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#  fk_rails_...  (user_id => users.id)
#
class Task < ApplicationRecord


    # Has many assocation with category
    belongs_to(
        :category,
        class_name: 'Category',
        foreign_key: 'category_id',
        inverse_of: :tasks
    )

    # Has many association with user for manager association
    belongs_to(
        :user,
        class_name: 'User',
        foreign_key: 'user_id',
        inverse_of: :tasks
    )

    #Has many association with comment
    has_many(
        :comments,
        class_name: 'Comment',
        foreign_key: 'task_id',
        inverse_of: :task,
        dependent: :destroy
    )

    # Many to Many association with user for permissons

    has_many :task_assignments, dependent: :destroy
    has_many :assigned_users, :through => :task_assignments, :source => :user

    has_many :task_can_edit_assignements, dependent: :destroy
    has_many :can_edit_users, :through => :task_can_edit_assignements, :source => :user

    has_many :task_can_delete_assignements, dependent: :destroy
    has_many :can_delete_users, :through => :task_can_delete_assignements, :source => :user

    has_many :task_can_assign_users_assignements, dependent: :destroy
    has_many :can_assign_users, :through => :task_can_assign_users_assignements, :source => :user

    has_many :task_can_remove_users_assignements, dependent: :destroy
    has_many :can_remove_users, :through =>  :task_can_remove_users_assignements, :source => :user
    
end
