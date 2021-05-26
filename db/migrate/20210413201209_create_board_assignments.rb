class CreateBoardAssignments < ActiveRecord::Migration[6.1]
  def change
    create_table :board_assignments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :board, null: false, foreign_key: true

      t.timestamps
    end
  end
end
