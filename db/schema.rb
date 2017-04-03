# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170403154543) do

  create_table "accounts", force: :cascade do |t|
    t.string   "user_name"
    t.string   "password"
    t.integer  "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "class_leaders", force: :cascade do |t|
    t.integer  "lecturer_id"
    t.integer  "student_class_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["lecturer_id"], name: "index_class_leaders_on_lecturer_id"
    t.index ["student_class_id"], name: "index_class_leaders_on_student_class_id"
  end

  create_table "class_subjects", force: :cascade do |t|
    t.string   "class_subject_id"
    t.integer  "subject_id"
    t.integer  "lecturer_id"
    t.integer  "semester_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["lecturer_id"], name: "index_class_subjects_on_lecturer_id"
    t.index ["semester_id"], name: "index_class_subjects_on_semester_id"
    t.index ["subject_id"], name: "index_class_subjects_on_subject_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string   "name"
    t.string   "admission_year"
    t.integer  "curriculum_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["curriculum_id"], name: "index_courses_on_curriculum_id"
  end

  create_table "curriculum_subjects", force: :cascade do |t|
    t.integer  "curriculum_id"
    t.integer  "subject_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["curriculum_id"], name: "index_curriculum_subjects_on_curriculum_id"
    t.index ["subject_id"], name: "index_curriculum_subjects_on_subject_id"
  end

  create_table "curriculums", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "end_semester_scores", force: :cascade do |t|
    t.string   "name"
    t.integer  "percent"
    t.integer  "class_subject_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["class_subject_id"], name: "index_end_semester_scores_on_class_subject_id"
  end

  create_table "excercise_scores", force: :cascade do |t|
    t.string   "name"
    t.integer  "percent"
    t.integer  "class_subject_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["class_subject_id"], name: "index_excercise_scores_on_class_subject_id"
  end

  create_table "faculties", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lecturers", force: :cascade do |t|
    t.string   "lecturer_number"
    t.string   "name"
    t.integer  "degree"
    t.string   "academic_title"
    t.integer  "position"
    t.integer  "gender"
    t.string   "birthday"
    t.string   "phone"
    t.string   "email"
    t.integer  "national_id"
    t.integer  "ethnic_id"
    t.integer  "religion_id"
    t.integer  "account_id"
    t.integer  "faculty_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["account_id"], name: "index_lecturers_on_account_id"
    t.index ["ethnic_id"], name: "index_lecturers_on_ethnic_id"
    t.index ["faculty_id"], name: "index_lecturers_on_faculty_id"
    t.index ["national_id"], name: "index_lecturers_on_national_id"
    t.index ["religion_id"], name: "index_lecturers_on_religion_id"
  end

  create_table "mid_semester_scores", force: :cascade do |t|
    t.string   "name"
    t.integer  "percent"
    t.integer  "class_subject_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["class_subject_id"], name: "index_mid_semester_scores_on_class_subject_id"
  end

  create_table "nationals", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "regencies", force: :cascade do |t|
    t.string   "name"
    t.integer  "plus_point"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "religions", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "scores", force: :cascade do |t|
    t.integer  "study_times"
    t.float    "avg_end_semester_score"
    t.float    "avg_mid_semester_score"
    t.float    "avg_excercise_score"
    t.float    "avg_score"
    t.float    "gpa_score"
    t.integer  "class_subject_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["class_subject_id"], name: "index_scores_on_class_subject_id"
  end

  create_table "semesters", force: :cascade do |t|
    t.integer  "name"
    t.string   "begin_time"
    t.string   "end_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "specializations", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "student_class_subjects", force: :cascade do |t|
    t.integer  "student_id"
    t.integer  "class_subject_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["class_subject_id"], name: "index_student_class_subjects_on_class_subject_id"
    t.index ["student_id"], name: "index_student_class_subjects_on_student_id"
  end

  create_table "student_classes", force: :cascade do |t|
    t.string   "name"
    t.integer  "total_student"
    t.integer  "number_month_school"
    t.integer  "faculty_id"
    t.integer  "course_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.index ["course_id"], name: "index_student_classes_on_course_id"
    t.index ["faculty_id"], name: "index_student_classes_on_faculty_id"
  end

  create_table "student_end_semester_scores", force: :cascade do |t|
    t.float    "score"
    t.integer  "student_id"
    t.integer  "end_semester_score_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.index ["end_semester_score_id"], name: "index_student_end_semester_scores_on_end_semester_score_id"
    t.index ["student_id"], name: "index_student_end_semester_scores_on_student_id"
  end

  create_table "student_excercise_semester_scores", force: :cascade do |t|
    t.float    "score"
    t.integer  "student_id"
    t.integer  "excercise_score_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["excercise_score_id"], name: "index_student_excercise_semester_scores_on_excercise_score_id"
    t.index ["student_id"], name: "index_student_excercise_semester_scores_on_student_id"
  end

  create_table "student_mid_semester_scores", force: :cascade do |t|
    t.float    "score"
    t.integer  "student_id"
    t.integer  "mid_semester_score_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.index ["mid_semester_score_id"], name: "index_student_mid_semester_scores_on_mid_semester_score_id"
    t.index ["student_id"], name: "index_student_mid_semester_scores_on_student_id"
  end

  create_table "student_semesters", force: :cascade do |t|
    t.string   "school_year"
    t.integer  "total_credit"
    t.float    "avg_score"
    t.integer  "student_id"
    t.integer  "semester_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["semester_id"], name: "index_student_semesters_on_semester_id"
    t.index ["student_id"], name: "index_student_semesters_on_student_id"
  end

  create_table "students", force: :cascade do |t|
    t.string   "student_number"
    t.string   "name"
    t.string   "avatar"
    t.integer  "gender"
    t.string   "birthday"
    t.string   "phone"
    t.string   "email"
    t.string   "address"
    t.string   "second_language"
    t.integer  "national_id"
    t.integer  "ethnic_id"
    t.integer  "religion_id"
    t.integer  "account_id"
    t.integer  "specialization_id"
    t.integer  "student_class_id"
    t.integer  "curriculum_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["account_id"], name: "index_students_on_account_id"
    t.index ["curriculum_id"], name: "index_students_on_curriculum_id"
    t.index ["ethnic_id"], name: "index_students_on_ethnic_id"
    t.index ["national_id"], name: "index_students_on_national_id"
    t.index ["religion_id"], name: "index_students_on_religion_id"
    t.index ["specialization_id"], name: "index_students_on_specialization_id"
    t.index ["student_class_id"], name: "index_students_on_student_class_id"
  end

  create_table "subjects", force: :cascade do |t|
    t.integer  "subject_id"
    t.string   "name"
    t.integer  "num_of_credit"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

end
