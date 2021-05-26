class CreateCategoryCanAssignUsersAssignements < ActiveRecord::Migration[6.1]
  def change
    create_table :category_can_assign_users_assignements do |t|
      t.references :user, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
