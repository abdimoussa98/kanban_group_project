# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  comment    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  task_id    :bigint
#  user_id    :bigint
#
# Indexes
#
#  index_comments_on_task_id  (task_id)
#  index_comments_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (task_id => tasks.id)
#  fk_rails_...  (user_id => users.id)
#
class Comment < ApplicationRecord

    #Has many association with task
    belongs_to(
        :task,
        class_name: 'Task',
        foreign_key: 'task_id',
        inverse_of: :comments
    )

    #Has many association with user
    belongs_to(
        :user,
        class_name: 'User',
        foreign_key: 'user_id',
        inverse_of: :comments
    )
end
