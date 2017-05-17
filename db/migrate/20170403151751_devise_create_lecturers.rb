class DeviseCreateLecturers < ActiveRecord::Migration[5.0]
  def change
    create_table :lecturers do |t|
      ## Database authenticatable
      t.string :lecturer_id,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      t.string :name
      t.string :avatar
      t.integer :degree
      t.integer :academic_rank
      t.string :academic_title
      t.integer :position
      t.integer :gender
      t.datetime :birthday
      t.string :phone
      t.string :email
      t.string :address

      t.references :national, foreign_key: true
      t.references :ethnic, foreign_key: true
      t.references :religion, foreign_key: true
      t.references :faculty, foreign_key: true
     
      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.inet     :current_sign_in_ip
      t.inet     :last_sign_in_ip

      ## Confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at


      t.timestamps null: false
    end

    add_index :lecturers, :lecturer_id,                unique: true
    add_index :lecturers, :reset_password_token, unique: true
    # add_index :lecturers, :confirmation_token,   unique: true
    # add_index :lecturers, :unlock_token,         unique: true
  end
end
