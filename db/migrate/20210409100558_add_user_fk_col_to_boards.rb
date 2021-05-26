class AddUserFkColToBoards < ActiveRecord::Migration[6.1]
  def change

    add_reference :boards, :user, foreign_key: true
  end
end
