# == Schema Information
#
# Table name: category_can_edit_assignements
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :bigint           not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_category_can_edit_assignements_on_category_id  (category_id)
#  index_category_can_edit_assignements_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#  fk_rails_...  (user_id => users.id)
#
require "test_helper"

class CategoryCanEditAssignementTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
