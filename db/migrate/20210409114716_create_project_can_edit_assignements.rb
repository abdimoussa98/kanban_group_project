class CreateProjectCanEditAssignements < ActiveRecord::Migration[6.1]
  def change
    create_table :project_can_edit_assignements do |t|
      t.references :user, null: false, foreign_key: true
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
