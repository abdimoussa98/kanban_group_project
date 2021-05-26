# == Schema Information
#
# Table name: category_can_remove_users_assignements
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :bigint           not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_category_can_remove_users_assignements_on_category_id  (category_id)
#  index_category_can_remove_users_assignements_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#  fk_rails_...  (user_id => users.id)
#
class CategoryCanRemoveUsersAssignement < ApplicationRecord
  belongs_to :user
  belongs_to :category
end
