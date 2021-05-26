# == Schema Information
#
# Table name: project_can_assign_users_assignements
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  project_id :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_project_can_assign_users_assignements_on_project_id  (project_id)
#  index_project_can_assign_users_assignements_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (project_id => projects.id)
#  fk_rails_...  (user_id => users.id)
#
require "test_helper"

class ProjectCanAssignUsersAssignementTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
