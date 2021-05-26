# == Schema Information
#
# Table name: projects
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
# Indexes
#
#  index_projects_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Project < ApplicationRecord

    # Has many association with Board
    has_many(
        :boards, 
        class_name: 'Board', 
        foreign_key: 'project_id',
        inverse_of: :project, 
        dependent: :destroy
    )

    # Has many association with user for manager association
    belongs_to(
        :user, 
        class_name: 'User',
        foreign_key: 'user_id',
        inverse_of: :projects
    )

    # Many to many association with user for projectprivleges

    has_many :project_assignements, dependent: :destroy
    has_many :assigned_users, :through => :project_assignements, :source => :user
    
    has_many :project_can_edit_assignements, dependent: :destroy
    has_many :can_edit_users, :through => :project_can_edit_assignements, :source => :user

    has_many :project_can_delete_assignements, dependent: :destroy
    has_many :can_delete_users, :through => :project_can_delete_assignements, :source => :user

    has_many :project_can_assign_users_assignements, dependent: :destroy
    has_many :can_assign_users, :through => :project_can_assign_users_assignements, :source => :user

    has_many :project_can_remove_users_assignements, dependent: :destroy
    has_many :can_remove_users, :through => :project_can_remove_users_assignements, :source => :user
    
end
