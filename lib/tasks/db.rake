require "ffaker"

namespace :db do
  desc "Seeding data"
  task seeding: :environment do
    if Rails.env.production?
      puts "Do not running in 'Production' task"
    else
      %w[db:drop db:create db:migrate db:seed].each do |task|
        Rake::Task[task].invoke
      end

      puts "Create Students"
      students =[ 
        ["102120191", "user123", 0, "15/10/1994", "0987322369", "abc1@gmail.com", "123 Nguyen luong bang", "anh van"],
        ["102120192", "user123", 0, "15/10/1994", "0987322369", "abc2@gmail.com", "123 Nguyen luong bang", "anh van"],
        ["102120193", "user123", 0, "15/10/1994", "0987322369", "abc3@gmail.com", "123 Nguyen luong bang", "anh van"],
        ["102120194", "user123", 0, "15/10/1994", "0987322369", "abc4@gmail.com", "123 Nguyen luong bang", "anh van"],
        ["102120195", "user123", 0, "15/10/1994", "0987322369", "abc5@gmail.com", "123 Nguyen luong bang", "anh van"],
        ["102120196", "user123", 0, "15/10/1994", "0987322369", "abc6@gmail.com", "123 Nguyen luong bang", "anh van"],
        ["102120197", "user123", 0, "15/10/1994", "0987322369", "abc7@gmail.com", "123 Nguyen luong bang", "anh van"],
        ["102120198", "user123", 0, "15/10/1994", "0987322369", "abc8@gmail.com", "123 Nguyen luong bang", "anh van"],
        ["102120199", "user123", 0, "15/10/1994", "0987322369", "abc9@gmail.com", "123 Nguyen luong bang", "anh van"],
      ]

      students.each do |student_id, password, gender, birthday, phone, email, address, second_language|
        student = Student.create(name: FFaker::Name.name, student_id: student_id, password: password, gender: gender,
          birthday: birthday, phone: phone, email: email, address: address, second_language: second_language)
      end
    end
  end
end