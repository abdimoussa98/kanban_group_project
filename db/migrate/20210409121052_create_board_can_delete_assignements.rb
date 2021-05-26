class CreateBoardCanDeleteAssignements < ActiveRecord::Migration[6.1]
  def change
    create_table :board_can_delete_assignements do |t|
      t.references :user, null: false, foreign_key: true
      t.references :board, null: false, foreign_key: true

      t.timestamps
    end
  end
end
