# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_04_13_201956) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "board_assignments", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "board_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["board_id"], name: "index_board_assignments_on_board_id"
    t.index ["user_id"], name: "index_board_assignments_on_user_id"
  end

  create_table "board_can_assign_users_assignements", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "board_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["board_id"], name: "index_board_can_assign_users_assignements_on_board_id"
    t.index ["user_id"], name: "index_board_can_assign_users_assignements_on_user_id"
  end

  create_table "board_can_delete_assignements", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "board_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["board_id"], name: "index_board_can_delete_assignements_on_board_id"
    t.index ["user_id"], name: "index_board_can_delete_assignements_on_user_id"
  end

  create_table "board_can_edit_assignements", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "board_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["board_id"], name: "index_board_can_edit_assignements_on_board_id"
    t.index ["user_id"], name: "index_board_can_edit_assignements_on_user_id"
  end

  create_table "board_can_remove_users_assignements", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "board_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["board_id"], name: "index_board_can_remove_users_assignements_on_board_id"
    t.index ["user_id"], name: "index_board_can_remove_users_assignements_on_user_id"
  end

  create_table "boards", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "project_id"
    t.bigint "user_id"
    t.index ["project_id"], name: "index_boards_on_project_id"
    t.index ["user_id"], name: "index_boards_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "board_id"
    t.bigint "user_id"
    t.index ["board_id"], name: "index_categories_on_board_id"
    t.index ["user_id"], name: "index_categories_on_user_id"
  end

  create_table "category_assignments", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "category_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_category_assignments_on_category_id"
    t.index ["user_id"], name: "index_category_assignments_on_user_id"
  end

  create_table "category_can_assign_users_assignements", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "category_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_category_can_assign_users_assignements_on_category_id"
    t.index ["user_id"], name: "index_category_can_assign_users_assignements_on_user_id"
  end

  create_table "category_can_delete_assignements", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "category_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_category_can_delete_assignements_on_category_id"
    t.index ["user_id"], name: "index_category_can_delete_assignements_on_user_id"
  end

  create_table "category_can_edit_assignements", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "category_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_category_can_edit_assignements_on_category_id"
    t.index ["user_id"], name: "index_category_can_edit_assignements_on_user_id"
  end

  create_table "category_can_remove_users_assignements", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "category_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_category_can_remove_users_assignements_on_category_id"
    t.index ["user_id"], name: "index_category_can_remove_users_assignements_on_user_id"
  end

  create_table "comments", force: :cascade do |t|
    t.string "comment"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "task_id"
    t.bigint "user_id"
    t.index ["task_id"], name: "index_comments_on_task_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "project_assignements", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "project_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["project_id"], name: "index_project_assignements_on_project_id"
    t.index ["user_id"], name: "index_project_assignements_on_user_id"
  end

  create_table "project_can_assign_users_assignements", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "project_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["project_id"], name: "index_project_can_assign_users_assignements_on_project_id"
    t.index ["user_id"], name: "index_project_can_assign_users_assignements_on_user_id"
  end

  create_table "project_can_delete_assignements", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "project_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["project_id"], name: "index_project_can_delete_assignements_on_project_id"
    t.index ["user_id"], name: "index_project_can_delete_assignements_on_user_id"
  end

  create_table "project_can_edit_assignements", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "project_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["project_id"], name: "index_project_can_edit_assignements_on_project_id"
    t.index ["user_id"], name: "index_project_can_edit_assignements_on_user_id"
  end

  create_table "project_can_remove_users_assignements", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "project_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["project_id"], name: "index_project_can_remove_users_assignements_on_project_id"
    t.index ["user_id"], name: "index_project_can_remove_users_assignements_on_user_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_projects_on_user_id"
  end

  create_table "task_assignments", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "task_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["task_id"], name: "index_task_assignments_on_task_id"
    t.index ["user_id"], name: "index_task_assignments_on_user_id"
  end

  create_table "task_can_assign_users_assignements", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "task_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["task_id"], name: "index_task_can_assign_users_assignements_on_task_id"
    t.index ["user_id"], name: "index_task_can_assign_users_assignements_on_user_id"
  end

  create_table "task_can_delete_assignements", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "task_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["task_id"], name: "index_task_can_delete_assignements_on_task_id"
    t.index ["user_id"], name: "index_task_can_delete_assignements_on_user_id"
  end

  create_table "task_can_edit_assignements", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "task_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["task_id"], name: "index_task_can_edit_assignements_on_task_id"
    t.index ["user_id"], name: "index_task_can_edit_assignements_on_user_id"
  end

  create_table "task_can_remove_users_assignements", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "task_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["task_id"], name: "index_task_can_remove_users_assignements_on_task_id"
    t.index ["user_id"], name: "index_task_can_remove_users_assignements_on_user_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "due_date"
    t.integer "estimated_work"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "category_id"
    t.bigint "user_id"
    t.index ["category_id"], name: "index_tasks_on_category_id"
    t.index ["user_id"], name: "index_tasks_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.boolean "is_admin"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "board_assignments", "boards"
  add_foreign_key "board_assignments", "users"
  add_foreign_key "board_can_assign_users_assignements", "boards"
  add_foreign_key "board_can_assign_users_assignements", "users"
  add_foreign_key "board_can_delete_assignements", "boards"
  add_foreign_key "board_can_delete_assignements", "users"
  add_foreign_key "board_can_edit_assignements", "boards"
  add_foreign_key "board_can_edit_assignements", "users"
  add_foreign_key "board_can_remove_users_assignements", "boards"
  add_foreign_key "board_can_remove_users_assignements", "users"
  add_foreign_key "boards", "projects"
  add_foreign_key "boards", "users"
  add_foreign_key "categories", "boards"
  add_foreign_key "categories", "users"
  add_foreign_key "category_assignments", "categories"
  add_foreign_key "category_assignments", "users"
  add_foreign_key "category_can_assign_users_assignements", "categories"
  add_foreign_key "category_can_assign_users_assignements", "users"
  add_foreign_key "category_can_delete_assignements", "categories"
  add_foreign_key "category_can_delete_assignements", "users"
  add_foreign_key "category_can_edit_assignements", "categories"
  add_foreign_key "category_can_edit_assignements", "users"
  add_foreign_key "category_can_remove_users_assignements", "categories"
  add_foreign_key "category_can_remove_users_assignements", "users"
  add_foreign_key "comments", "tasks"
  add_foreign_key "comments", "users"
  add_foreign_key "project_assignements", "projects"
  add_foreign_key "project_assignements", "users"
  add_foreign_key "project_can_assign_users_assignements", "projects"
  add_foreign_key "project_can_assign_users_assignements", "users"
  add_foreign_key "project_can_delete_assignements", "projects"
  add_foreign_key "project_can_delete_assignements", "users"
  add_foreign_key "project_can_edit_assignements", "projects"
  add_foreign_key "project_can_edit_assignements", "users"
  add_foreign_key "project_can_remove_users_assignements", "projects"
  add_foreign_key "project_can_remove_users_assignements", "users"
  add_foreign_key "projects", "users"
  add_foreign_key "task_assignments", "tasks"
  add_foreign_key "task_assignments", "users"
  add_foreign_key "task_can_assign_users_assignements", "tasks"
  add_foreign_key "task_can_assign_users_assignements", "users"
  add_foreign_key "task_can_delete_assignements", "tasks"
  add_foreign_key "task_can_delete_assignements", "users"
  add_foreign_key "task_can_edit_assignements", "tasks"
  add_foreign_key "task_can_edit_assignements", "users"
  add_foreign_key "task_can_remove_users_assignements", "tasks"
  add_foreign_key "task_can_remove_users_assignements", "users"
  add_foreign_key "tasks", "categories"
  add_foreign_key "tasks", "users"
end
