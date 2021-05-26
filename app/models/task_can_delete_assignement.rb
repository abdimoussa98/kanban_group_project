# == Schema Information
#
# Table name: task_can_delete_assignements
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  task_id    :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_task_can_delete_assignements_on_task_id  (task_id)
#  index_task_can_delete_assignements_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (task_id => tasks.id)
#  fk_rails_...  (user_id => users.id)
#
class TaskCanDeleteAssignement < ApplicationRecord
  belongs_to :user
  belongs_to :task
end
