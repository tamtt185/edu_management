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

ActiveRecord::Schema.define(version: 20170403174420) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "class_leaders", force: :cascade do |t|
    t.integer  "lecturer_id"
    t.integer  "student_class_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["lecturer_id"], name: "index_class_leaders_on_lecturer_id", using: :btree
    t.index ["student_class_id"], name: "index_class_leaders_on_student_class_id", using: :btree
  end

  create_table "class_subjects", force: :cascade do |t|
    t.string   "class_subject_id"
    t.integer  "subject_id"
    t.integer  "lecturer_id"
    t.integer  "semester_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["lecturer_id"], name: "index_class_subjects_on_lecturer_id", using: :btree
    t.index ["semester_id"], name: "index_class_subjects_on_semester_id", using: :btree
    t.index ["subject_id"], name: "index_class_subjects_on_subject_id", using: :btree
  end

  create_table "courses", force: :cascade do |t|
    t.string   "name"
    t.string   "admission_year"
    t.integer  "curriculum_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["curriculum_id"], name: "index_courses_on_curriculum_id", using: :btree
  end

  create_table "curriculum_subjects", force: :cascade do |t|
    t.integer  "curriculum_id"
    t.integer  "subject_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["curriculum_id"], name: "index_curriculum_subjects_on_curriculum_id", using: :btree
    t.index ["subject_id"], name: "index_curriculum_subjects_on_subject_id", using: :btree
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
    t.index ["class_subject_id"], name: "index_end_semester_scores_on_class_subject_id", using: :btree
  end

  create_table "ethnics", force: :cascade do |t|
    t.string   "name"
    t.integer  "national_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["national_id"], name: "index_ethnics_on_national_id", using: :btree
  end

  create_table "excercise_scores", force: :cascade do |t|
    t.string   "name"
    t.integer  "percent"
    t.integer  "class_subject_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["class_subject_id"], name: "index_excercise_scores_on_class_subject_id", using: :btree
  end

  create_table "faculties", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "id_cards", force: :cascade do |t|
    t.string   "number_id"
    t.string   "date_of_issued"
    t.integer  "student_id"
    t.integer  "province_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["province_id"], name: "index_id_cards_on_province_id", using: :btree
    t.index ["student_id"], name: "index_id_cards_on_student_id", using: :btree
  end

  create_table "lecturers", force: :cascade do |t|
    t.string   "lecturer_id",            default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "name"
    t.integer  "degree"
    t.string   "academic_title"
    t.integer  "position"
    t.integer  "gender"
    t.string   "birthday"
    t.string   "phone"
    t.string   "email"
    t.string   "address"
    t.integer  "national_id"
    t.integer  "ethnic_id"
    t.integer  "religion_id"
    t.integer  "faculty_id"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["ethnic_id"], name: "index_lecturers_on_ethnic_id", using: :btree
    t.index ["faculty_id"], name: "index_lecturers_on_faculty_id", using: :btree
    t.index ["lecturer_id"], name: "index_lecturers_on_lecturer_id", unique: true, using: :btree
    t.index ["national_id"], name: "index_lecturers_on_national_id", using: :btree
    t.index ["religion_id"], name: "index_lecturers_on_religion_id", using: :btree
    t.index ["reset_password_token"], name: "index_lecturers_on_reset_password_token", unique: true, using: :btree
  end

  create_table "mid_semester_scores", force: :cascade do |t|
    t.string   "name"
    t.integer  "percent"
    t.integer  "class_subject_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["class_subject_id"], name: "index_mid_semester_scores_on_class_subject_id", using: :btree
  end

  create_table "nationals", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "provinces", force: :cascade do |t|
    t.string   "name"
    t.integer  "national_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["national_id"], name: "index_provinces_on_national_id", using: :btree
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
    t.integer  "student_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["class_subject_id"], name: "index_scores_on_class_subject_id", using: :btree
    t.index ["student_id"], name: "index_scores_on_student_id", using: :btree
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
    t.index ["class_subject_id"], name: "index_student_class_subjects_on_class_subject_id", using: :btree
    t.index ["student_id"], name: "index_student_class_subjects_on_student_id", using: :btree
  end

  create_table "student_classes", force: :cascade do |t|
    t.string   "name"
    t.integer  "total_student"
    t.integer  "number_month_school"
    t.integer  "faculty_id"
    t.integer  "course_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.index ["course_id"], name: "index_student_classes_on_course_id", using: :btree
    t.index ["faculty_id"], name: "index_student_classes_on_faculty_id", using: :btree
  end

  create_table "student_end_semester_scores", force: :cascade do |t|
    t.float    "score"
    t.integer  "student_id"
    t.integer  "end_semester_score_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.index ["end_semester_score_id"], name: "index_student_end_semester_scores_on_end_semester_score_id", using: :btree
    t.index ["student_id"], name: "index_student_end_semester_scores_on_student_id", using: :btree
  end

  create_table "student_excercise_scores", force: :cascade do |t|
    t.float    "score"
    t.integer  "student_id"
    t.integer  "excercise_score_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["excercise_score_id"], name: "index_student_excercise_scores_on_excercise_score_id", using: :btree
    t.index ["student_id"], name: "index_student_excercise_scores_on_student_id", using: :btree
  end

  create_table "student_mid_semester_scores", force: :cascade do |t|
    t.float    "score"
    t.integer  "student_id"
    t.integer  "mid_semester_score_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.index ["mid_semester_score_id"], name: "index_student_mid_semester_scores_on_mid_semester_score_id", using: :btree
    t.index ["student_id"], name: "index_student_mid_semester_scores_on_student_id", using: :btree
  end

  create_table "student_semesters", force: :cascade do |t|
    t.string   "school_year"
    t.integer  "total_credit"
    t.float    "avg_score"
    t.integer  "student_id"
    t.integer  "semester_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["semester_id"], name: "index_student_semesters_on_semester_id", using: :btree
    t.index ["student_id"], name: "index_student_semesters_on_student_id", using: :btree
  end

  create_table "students", force: :cascade do |t|
    t.string   "student_id",             default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
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
    t.integer  "regency_id"
    t.integer  "province_id"
    t.integer  "specialization_id"
    t.integer  "student_class_id"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["ethnic_id"], name: "index_students_on_ethnic_id", using: :btree
    t.index ["national_id"], name: "index_students_on_national_id", using: :btree
    t.index ["province_id"], name: "index_students_on_province_id", using: :btree
    t.index ["regency_id"], name: "index_students_on_regency_id", using: :btree
    t.index ["religion_id"], name: "index_students_on_religion_id", using: :btree
    t.index ["reset_password_token"], name: "index_students_on_reset_password_token", unique: true, using: :btree
    t.index ["specialization_id"], name: "index_students_on_specialization_id", using: :btree
    t.index ["student_class_id"], name: "index_students_on_student_class_id", using: :btree
    t.index ["student_id"], name: "index_students_on_student_id", unique: true, using: :btree
  end

  create_table "subjects", force: :cascade do |t|
    t.string   "subject_id"
    t.string   "name"
    t.float    "num_of_credit"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_foreign_key "class_leaders", "lecturers"
  add_foreign_key "class_leaders", "student_classes"
  add_foreign_key "class_subjects", "lecturers"
  add_foreign_key "class_subjects", "semesters"
  add_foreign_key "class_subjects", "subjects"
  add_foreign_key "courses", "curriculums"
  add_foreign_key "curriculum_subjects", "curriculums"
  add_foreign_key "curriculum_subjects", "subjects"
  add_foreign_key "end_semester_scores", "class_subjects"
  add_foreign_key "ethnics", "nationals"
  add_foreign_key "excercise_scores", "class_subjects"
  add_foreign_key "id_cards", "provinces"
  add_foreign_key "id_cards", "students"
  add_foreign_key "lecturers", "ethnics"
  add_foreign_key "lecturers", "faculties"
  add_foreign_key "lecturers", "nationals"
  add_foreign_key "lecturers", "religions"
  add_foreign_key "mid_semester_scores", "class_subjects"
  add_foreign_key "provinces", "nationals"
  add_foreign_key "scores", "class_subjects"
  add_foreign_key "scores", "students"
  add_foreign_key "student_class_subjects", "class_subjects"
  add_foreign_key "student_class_subjects", "students"
  add_foreign_key "student_classes", "courses"
  add_foreign_key "student_classes", "faculties"
  add_foreign_key "student_end_semester_scores", "end_semester_scores"
  add_foreign_key "student_end_semester_scores", "students"
  add_foreign_key "student_excercise_scores", "excercise_scores"
  add_foreign_key "student_excercise_scores", "students"
  add_foreign_key "student_mid_semester_scores", "mid_semester_scores"
  add_foreign_key "student_mid_semester_scores", "students"
  add_foreign_key "student_semesters", "semesters"
  add_foreign_key "student_semesters", "students"
  add_foreign_key "students", "ethnics"
  add_foreign_key "students", "nationals"
  add_foreign_key "students", "provinces"
  add_foreign_key "students", "regencies"
  add_foreign_key "students", "religions"
  add_foreign_key "students", "specializations"
  add_foreign_key "students", "student_classes"
end
