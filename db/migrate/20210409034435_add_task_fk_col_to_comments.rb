class AddTaskFkColToComments < ActiveRecord::Migration[6.1]
  def change
    add_reference :comments, :task, foreign_key: true
  end
end
