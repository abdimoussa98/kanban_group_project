class AddProjectFkColToBoards < ActiveRecord::Migration[6.1]
  def change
    add_reference :boards, :project, foreign_key: true
  end
end
