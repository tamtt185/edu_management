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

      puts "Create admin account"
      Admin.create(name: "Admin", password: "123456", gender: 1,
        birthday: "18/05/1994", phone: "0987676767", email: "admin@gmail.com", address: "Nguyen luong bang")
    
      puts "Create Nationals"
      vietnam = National.create(name: "Việt nam");
      National.create(name: "Lào");

      puts "Create ethnics of Vietnam"
      ethnics = [
        "Kinh", "Tày", "Thái", "Mường", "Hoa", "Khơ-me", "Nùng", "Hơmông", "Dao",
        "Gia-rai", "Ê-đê", "Ba-na", "Sán Cháy", "Chăm", "Xơ-đăng", "Sán Diù",
        "Hrê", "Cơ-ho", "Ra-glay", "Mnông", "Thổ", "X'tiêng", "Khơmú", "Bru-Vân Kiều",
        "Giáy", "Cơ-tu", "Gié-Triêng", "Ta-ôi", "Mạ", "Co", "Chơ-ro", "Hà Nhì", "Xinh-mun",
        "Chu-ru", "Lào", "La-chí", "Phù Lá", "La Hủ", "Kháng", "Lự", "Pà Thẻn", "LôLô",
        "Chứt", "Mảng", "Cờ lao", "Bố Y", "La Ha", "Cống", "Ngái", "Si La", "Pu Piéo",
        "Brâu", "Rơ-măm", "Ơ-đu"
      ]
      ethnics.each do |name|
        Ethnic.create(national_id: vietnam.id, name: name)
      end

      puts "Create Specializations"
      specializations = [
        "Công nghệ thông tin", "Điện tử viễn thông"
      ]
      specializations.each do |name|
        Specialization.create(name: name)
      end

      puts "Create religions of Viet Nam"
      religions = [
        "Không", "Công giáo", "Phật giáo", "Cao đài", "Hòa hảo", "Tin lành", "Bà la môn", 
        "Minh sư đạo", "Minh lý đạo", "Tịnh độ cư sỹ Phật hội Việt Nam", "Đạo tứ ấn hiếu nghĩa",
        "Bửu sơn kỳ hương", "Hồi giáo", "Khác"
      ]
      religions.each do |name|
        Religion.create(name: name)
      end

        Regency.create(name: "Lớp trưởng", plus_point: 0.3)
        Regency.create(name: "Lớp phó", plus_point: 0.2)
        Regency.create(name: "Bí thư", plus_point: 0.2)
        Regency.create(name: "Ủy viên", plus_point: 0.2)

      puts "Create faculties"
      cntt = Faculty.create(name: "Công nghệ thông tin")
      Faculty.create(name: "Điện tử viển thông")

      puts "Create sujects"
      subject1 = Subject.create(subject_id: "HP001", name: "Học phần 001", num_of_credit: 2, is_elective: 0)
      subject2 = Subject.create(subject_id: "HP002", name: "Học phần 002", num_of_credit: 0.5, parallel_subject_id: subject1.id, is_elective: 0)
      subject3 = Subject.create(subject_id: "HP003", name: "Học phần 003", num_of_credit: 1.5,  parallel_subject_id: subject2.id, prerequisite_subject_id: subject1.id, is_elective: 0)
      subject4 =Subject.create(subject_id: "HP004", name: "Học phân 004", num_of_credit: 2)

      puts "Create curriculums of IT faculty"
      cur = Curriculum.create(curriculum_id: "CTDT001", name: "Công nghệ thông tin K12", faculty_id: cntt.id)
      Curriculum.create(curriculum_id: "CTDT002", name: "Công nghệ thông tin K13", faculty_id: cntt.id)
      Curriculum.create(curriculum_id: "CTDT003", name: "Công nghệ thông tin K14", faculty_id: cntt.id)
      
      puts "Create subject of curriculum"
      CurriculumSubject.create(semester: 1, curriculum_subject_id: "HP_CTDT." + subject1.id.to_s + "." + cur.id.to_s, subject_id: subject1.id, curriculum_id: cur.id)
      CurriculumSubject.create(semester: 1, curriculum_subject_id: "HP_CTDT." + subject2.id.to_s + "." + cur.id.to_s, subject_id: subject2.id, curriculum_id: cur.id)
      CurriculumSubject.create(semester: 1, curriculum_subject_id: "HP_CTDT." + subject3.id.to_s + "." + cur.id.to_s, subject_id: subject3.id, curriculum_id: cur.id)
      CurriculumSubject.create(semester: 1, curriculum_subject_id: "HP_CTDT." + subject4.id.to_s + "." + cur.id.to_s, subject_id: subject4.id, curriculum_id: cur.id)

      puts "Create student class"
      student_class = StudentClass.create(student_class_id: "10212121", name: "12T1", faculty_id: cntt.id)
      StudentClass.create(student_class_id: "10212122", name: "12T2", faculty_id: cntt.id)
      StudentClass.create(student_class_id: "10212123", name: "12T3", faculty_id: cntt.id)

      puts "Create courses"
      course = Course.create(name: "12", admission_year: "2012")
      Course.create(name: "13", admission_year: "2012")
      Course.create(name: "14", admission_year: "2012")
      Course.create(name: "15", admission_year: "2012")

      puts "Create semesters"
      sem = Semester.create(semester_id: "121310", name: "Học kỳ 1", period: "2012-2013")
     
      puts "Create Students"
      students =[ 
        ["102120191", "user123", :male, "15/10/1994", "0987322369", "SV1@gmail.com", "123 Nguyen luong bang", "anh van"],
        ["102120192", "user123", :male, "15/10/1994", "0987322369", "SV2@gmail.com", "123 Nguyen luong bang", "anh van"],
        ["102120293", "user123", :male, "15/10/1994", "0987322369", "SV10@gmail.com", "123 Nguyen luong bang", "anh van"],
        ["102120194", "user123", :male, "15/10/1994", "0987322369", "SV4@gmail.com", "123 Nguyen luong bang", "anh van"],
        ["102120195", "user123", :male, "15/10/1994", "0987322369", "SV5@gmail.com", "123 Nguyen luong bang", "anh van"],
        ["102120196", "user123", :male, "15/10/1994", "0987322369", "SV6@gmail.com", "123 Nguyen luong bang", "anh van"],
        ["102120197", "user123", :male, "15/10/1994", "0987322369", "SV7@gmail.com", "123 Nguyen luong bang", "anh van"],
        ["102120198", "user123", :male, "15/10/1994", "0987322369", "SV8@gmail.com", "123 Nguyen luong bang", "anh van"],
        ["102120199", "user123", :male, "15/10/1994", "0987322369", "SV9@gmail.com", "123 Nguyen luong bang", "anh van"]
      ]

      students.each do |student_id, password, gender, birthday, phone, email, address, second_language|
        Student.create(name: FFaker::Name.name, student_id: student_id, password: password, gender: gender, curriculum_id: cur.id,
          birthday: birthday, phone: phone, email: email, address: address, second_language: second_language, course_id: course.id, student_class_id: student_class.id)
      end

      puts "Create Lecturers"
      lecuturers =[
        ["GV002", "user123", 0, "academic 1", 1, :male, "15/10/1994", "0987322369", "GV2@gmail.com", "123 Nguyen luong bang"],
        ["GV003", "user123", 0, "academic 1", 1, :male, "15/10/1994", "0987322369", "GV3@gmail.com", "123 Nguyen luong bang"],
        ["GV004", "user123", 0, "academic 1", 1, :male, "15/10/1994", "0987322369", "GV4@gmail.com", "123 Nguyen luong bang"],
        ["GV005", "user123", 0, "academic 1", 1, :male, "15/10/1994", "0987322369", "GV5@gmail.com", "123 Nguyen luong bang"],
        ["GV006", "user123", 0, "academic 1", 1, :male, "15/10/1994", "0987322369", "GV6@gmail.com", "123 Nguyen luong bang"],
        ["GV007", "user123", 0, "academic 1", 1, :male, "15/10/1994", "0987322369", "GV7@gmail.com", "123 Nguyen luong bang"],
        ["GV008", "user123", 0, "academic 1", 1, :male, "15/10/1994", "0987322369", "GV8@gmail.com", "123 Nguyen luong bang"],
        ["GV009", "user123", 0, "academic 1", 1, :male, "15/10/1994", "0987322369", "GV9@gmail.com", "123 Nguyen luong bang"],
        ["GV010", "user123", 0, "academic 1", 1, :male, "15/10/1994", "0987322369", "GV10@gmail.com", "123 Nguyen luong bang"],
      ]

      lecuturers.each do |lecturer_id, password, degree, academic_title, position, gender, birthday, phone, email, address|
        Lecturer.create(name: FFaker::Name.name, lecturer_id: lecturer_id, password: password, degree: degree, gender: gender,
                academic_title: academic_title, position: position, birthday: birthday, phone: phone, email: email, address: address)
      end

      lecturer = Lecturer.create(name: "Giang vien", lecturer_id: "GV001", password: "123456", degree: 0, gender: 1,
          academic_title: "academic_title", position: 1, birthday: "18/05/1994", phone: "0987676767", email: "email@gmail.com", address: "Nguyen luong bang")
      student = Student.create(name: "Trần Thanh Tâm", student_id: "102120190", password: "123456", gender: 1, curriculum_id: cur.id, student_class_id: student_class.id,
          birthday: "18/09/1993", phone: "0987322369", email: "sinhvien@gmail.com", address: "Nguyen luong bang", second_language: "Anh van", course_id: course.id)
     
      puts "Create lecturer of subject"
      lecturer_subject = LecturerSubject.create(lecturer_subject_id: lecturer.lecturer_id + "." + subject1.subject_id, lecturer_id: lecturer.id, subject_id: subject1.id)

      puts "Create class subjects"
      class_subject = ClassSubject.create(class_subject_id: lecturer_subject.lecturer_subject_id, lecturer_subject_id: lecturer_subject.id, semester_id: sem.id)      
      bt = class_subject.scores.create(name: "Bài tập", score_type: :exercise, percent: 20)
      dbt = bt.sub_scores.create(name: "BT", percent: 100) 
      gk = class_subject.scores.create(name: "Giữa kỳ", score_type: :mid_semester,  percent: 20)
      dgk = gk.sub_scores.create(name: "GK", percent: 100)
      ck = class_subject.scores.create(name: "Cuối kỳ", score_type: :end_semester,  percent: 60)
      dck = ck.sub_scores.create(name: "CK", percent: 100) 

      puts "Create student of class subject"
      StudentClassSubject.create(student_class_subject_id:  + student.student_id + "." + class_subject.class_subject_id, class_subject_id: class_subject.id, student_id: student.id)
      StudentClassSubject.create(student_class_subject_id: "102120191." + class_subject.class_subject_id,class_subject_id: class_subject.id, student_id: 1)
      StudentClassSubject.create(student_class_subject_id: "102120192." + class_subject.class_subject_id,class_subject_id: class_subject.id, student_id: 2)
      StudentClassSubject.create(student_class_subject_id: "102120193." + class_subject.class_subject_id,class_subject_id: class_subject.id, student_id: 3)
      StudentClassSubject.create(student_class_subject_id: "102120194." + class_subject.class_subject_id,class_subject_id: class_subject.id, student_id: 4)
      StudentClassSubject.create(student_class_subject_id: "102120195." + class_subject.class_subject_id,class_subject_id: class_subject.id, student_id: 5)
      StudentClassSubject.create(student_class_subject_id: "102120196." + class_subject.class_subject_id,class_subject_id: class_subject.id, student_id: 6)
      
      puts "Create Class leader"
      ClassLeader.create(lecturer_id: lecturer.id, student_class_id: student_class.id)

      puts "Create scores of student"
      StudentSubScore.create(student_id: student.id, sub_score_id: dbt.id, score: 7, is_confirm: 1)
      StudentSubScore.create(student_id: student.id, sub_score_id: dgk.id, score: 8, is_confirm: 1)
      StudentSubScore.create(student_id: student.id, sub_score_id: dck.id, score: 9, is_confirm: 1)
      
      6.times do |i|
        StudentSubScore.create(student_id: i+1, sub_score_id: dbt.id, score: 6, is_confirm: 1)
        StudentSubScore.create(student_id: i+1, sub_score_id: dgk.id, score: 8, is_confirm: 1)
        StudentSubScore.create(student_id: i+1, sub_score_id: dck.id, score: 7, is_confirm: 1)
      end
    end
  end
end