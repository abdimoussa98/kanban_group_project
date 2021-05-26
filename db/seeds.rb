# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# User Generation
user1 = User.create!(
  email: "bob@email.com",
  password: "password",
  is_admin: false, 
  name: "Bob Bobbington"
)

user2 = User.create!(
  email: "alice@email.com",
  password: "password",
  is_admin: false, 
  name: "Alice Alicer"
)
# Admin Account
user3 = User.create!(
  email: "admin@email.com",
  password: "password",
  is_admin: true, 
  name: "Admin Adminstration"
)
# Project creation
project1 = Project.create!(
  name: "Sloth Industries",
  user: user1
)

#Board creation
board1 = Board.create!(
  name: "Financial Goals",
  project: project1,
  user: user1
)

# Category Creation
category1 = Category.create!(
  name: "Make Costs of Production",
  board: board1,
  user: user1
)

category2 = Category.create!(
  name: "Increase Profits by at least 1%",
  board: board1,
  user: user1
)

#task creation, estimated work is in minutes

task1 = Task.create!(
  name: "Make Rent Costs",
  description: "Make enough to pay for the costs of rent",
  due_date: "5/1/21",
  estimated_work: 300,
  category: category1,
  user: user1
)

task2 = Task.create!(
  name: "Employee Cost",
  description: "Make enough to pay for the costs of employees",
  due_date: "5/1/21",
  estimated_work: 600,
  category: category1,
  user: user1
)

task3 = Task.create!(
  name: "Promote and advertise.",
  description: "Encourage and advertise through social medial presence.",
  due_date: "6/1/21",
  estimated_work: 240,
  category: category2,
  user: user1
)

comment1 = Comment.create!(
  comment: "This task must be done ASAP!!!",
  task: task1,
  user: user1
)

comment2 = Comment.create!(
  comment: "I'm sure this will get us back on track!",
  task: task2,
  user: user2
)

comment3 = Comment.create!(
  comment: "I think Instagram is so 2014. We should be focusing on TikTok!",
  task: task3,
  user: user3
)

#many to many associations
project1.assigned_users << [user1]
project1.can_edit_users << [user1]
project1.can_delete_users << [user1]
project1.can_assign_users << [user1]
project1.can_remove_users << [user1]
board1.assigned_users << [user1]
board1.can_edit_users << [user1]
board1.can_delete_users << [user1]
board1.can_assign_users << [user1]
board1.can_remove_users << [user1]
category1.assigned_users << [user1]
category1.can_edit_users << [user1]
category1.can_delete_users << [user1]
category1.can_assign_users << [user1]
category1.can_remove_users << [user1]
category2.assigned_users << [user1]
category2.can_edit_users << [user1]
category2.can_delete_users << [user1]
category2.can_assign_users << [user1]
category2.can_remove_users << [user1]
task1.assigned_users << [user1]
task1.can_edit_users << [user1]
task1.can_delete_users << [user1]
task1.can_assign_users << [user1]
task1.can_remove_users << [user1]
task2.assigned_users << [user1]
task2.can_edit_users << [user1]
task2.can_delete_users << [user1]
task2.can_assign_users << [user1]
task2.can_remove_users << [user1]
task3.assigned_users << [user1]
task3.can_edit_users << [user1]
task3.can_delete_users << [user1]
task3.can_assign_users << [user1]
task3.can_remove_users << [user1]