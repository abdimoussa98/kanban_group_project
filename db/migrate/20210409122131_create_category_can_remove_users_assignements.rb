class CreateCategoryCanRemoveUsersAssignements < ActiveRecord::Migration[6.1]
  def change
    create_table :category_can_remove_users_assignements do |t|
      t.references :user, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
