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

      puts "Create Nationals"
      vietnam = National.create(name: "Việt nam");
      National.create(name: "Lào");

      puts "Create Provinces of Vietnam"
      provinces = [
        "An Giang", "Bà Rịa - Vũng Tàu", "Bắc Giang", "Bắc Kạn", "Bạc Liêu", "Bắc Ninh",
        "Bến Tre", "Bình Định", "Bình Dương", "Bình Phước", "Bình Thuận", "Cà Mau",
        "Cao Bằng", "Đắk Lắk", "Đắk Nông", "Điện Biên", "Đồng Nai", "Đồng Tháp", "Gia Lai",
        "Hà Giang", "Hà Nam", "Hà Tĩnh", "Hải Dương", "Hậu Giang", "Hòa Bình", "Hưng Yên",
        "Khánh Hòa", "Kiên Giang", "Kon Tum", "Lai Châu", "Lâm Đồng", "Lạng Sơn", "Lào Cai",
        "Long An", "Nam Định", "Nghệ An", "Ninh Bình", "Ninh Thuận", "Phú Thọ", "Quảng Bình",
        "Quảng Nam", "Quảng Ngãi", "Quảng Ninh", "Quảng Trị", "Sóc Trăng", "Sơn La", "Tây Ninh",
        "Thái Bình", "Thái Nguyên", "Thanh Hóa", "Thừa Thiên Huế", "Tiền Giang", "Trà Vinh",
        "Tuyên Quang", "Vĩnh Long", "Vĩnh Phúc", "Yên Bái", "Phú Yên", "Cần Thơ", "Đà Nẵng",
        "Hải Phòng", "Hà Nội", "TP HCM"
      ]
      provinces.each do |name|
        Province.create(national_id: vietnam.id, name: name)
      end

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

      puts "Create regencies"
      regencies = {
        "": 0,
        "Lớp trưởng": 0.3,
        "Lớp phó": 0.2,
        "Bí thư": 0.3,
        "Ủy viên": 0.2,
      }
      regencies.each do |name, plus_point|
        Regency.create(name: name, plus_point: plus_point)
      end

      puts "Create faculties"
      cntt = Faculty.create(name: "Công nghệ thông tin")
      Faculty.create(name: "Điện tử viển thông")

      puts "Create sujects"
      subject1 = Subject.create(subject_id: "SJ001", name: "Subject 001", num_of_credit: 2, is_elective: 0)
      subject2 = Subject.create(subject_id: "SJ002", name: "Subject 002", num_of_credit: 0.5, parallel_subject_id: subject1.id, is_elective: 0)
      subject3 = Subject.create(subject_id: "SJ003", name: "Subject 003", num_of_credit: 1.5,  parallel_subject_id: subject2.id, prerequisite_subject_id: subject1.id, is_elective: 0)
      subject4 =Subject.create(subject_id: "SJ004", name: "Subject 004", num_of_credit: 2)

      puts "Create curriculums of IT faculty"
      cur = Curriculum.create(curriculum_id: "CTDT001", name: "Công nghệ thông tin K12", faculty_id: cntt.id)
      Curriculum.create(curriculum_id: "CTDT002", name: "Công nghệ thông tin K13", faculty_id: cntt.id)
      Curriculum.create(curriculum_id: "CTDT003", name: "Công nghệ thông tin K14", faculty_id: cntt.id)
      
      puts "Create subject of curriculum"
      CurriculumSubject.create(subject_id: subject1.id, curriculum_id: cur.id)
      CurriculumSubject.create(subject_id: subject2.id, curriculum_id: cur.id)
      CurriculumSubject.create(subject_id: subject3.id, curriculum_id: cur.id)
      CurriculumSubject.create(subject_id: subject4.id, curriculum_id: cur.id)

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
      sem = Semester.create(name: "1", begin_time: "2012", end_time: "2013")
      Semester.create(name: "2", begin_time: "2012", end_time: "2013")
      Semester.create(name: "1", begin_time: "2013", end_time: "2014")
      Semester.create(name: "2", begin_time: "2013", end_time: "2014")
      Semester.create(name: "1", begin_time: "2014", end_time: "2015")
      Semester.create(name: "2", begin_time: "2014", end_time: "2015")
     
      puts "Create Students"
      students =[ 
        ["102120191", "user123", :male, "15/10/1994", "0987322369", "abc1@gmail.com", "123 Nguyen luong bang", "anh van"],
        ["102120192", "user123", :male, "15/10/1994", "0987322369", "abc2@gmail.com", "123 Nguyen luong bang", "anh van"],
        ["102120193", "user123", :male, "15/10/1994", "0987322369", "abc3@gmail.com", "123 Nguyen luong bang", "anh van"],
        ["102120194", "user123", :male, "15/10/1994", "0987322369", "abc4@gmail.com", "123 Nguyen luong bang", "anh van"],
        ["102120195", "user123", :male, "15/10/1994", "0987322369", "abc5@gmail.com", "123 Nguyen luong bang", "anh van"],
        ["102120196", "user123", :male, "15/10/1994", "0987322369", "abc6@gmail.com", "123 Nguyen luong bang", "anh van"],
        ["102120197", "user123", :male, "15/10/1994", "0987322369", "abc7@gmail.com", "123 Nguyen luong bang", "anh van"],
        ["102120198", "user123", :male, "15/10/1994", "0987322369", "abc8@gmail.com", "123 Nguyen luong bang", "anh van"],
        ["102120199", "user123", :male, "15/10/1994", "0987322369", "abc9@gmail.com", "123 Nguyen luong bang", "anh van"],
      ]

      students.each do |student_id, password, gender, birthday, phone, email, address, second_language|
        Student.create(name: FFaker::Name.name, student_id: student_id, password: password, gender: gender, curriculum_id: cur.id,
          birthday: birthday, phone: phone, email: email, address: address, second_language: second_language, course_id: course.id, student_class_id: student_class.id)
      end

      puts "Create Lecturers"
      lecuturers =[
        ["0102120191", "user123", 0, "academic 1", 1, :male, "15/10/1994", "0987322369", "abc1@gmail.com", "123 Nguyen luong bang"],
        ["0102120192", "user123", 0, "academic 1", 1, :male, "15/10/1994", "0987322369", "abc2@gmail.com", "123 Nguyen luong bang"],
        ["0102120193", "user123", 0, "academic 1", 1, :male, "15/10/1994", "0987322369", "abc3@gmail.com", "123 Nguyen luong bang"],
        ["0102120194", "user123", 0, "academic 1", 1, :male, "15/10/1994", "0987322369", "abc4@gmail.com", "123 Nguyen luong bang"],
        ["0102120195", "user123", 0, "academic 1", 1, :male, "15/10/1994", "0987322369", "abc5@gmail.com", "123 Nguyen luong bang"],
        ["0102120196", "user123", 0, "academic 1", 1, :male, "15/10/1994", "0987322369", "abc6@gmail.com", "123 Nguyen luong bang"],
        ["0102120197", "user123", 0, "academic 1", 1, :male, "15/10/1994", "0987322369", "abc7@gmail.com", "123 Nguyen luong bang"],
        ["0102120198", "user123", 0, "academic 1", 1, :male, "15/10/1994", "0987322369", "abc8@gmail.com", "123 Nguyen luong bang"],
        ["0102120199", "user123", 0, "academic 1", 1, :male, "15/10/1994", "0987322369", "abc9@gmail.com", "123 Nguyen luong bang"],
      ]

      lecuturers.each do |lecturer_id, password, degree, academic_title, position, gender, birthday, phone, email, address|
        Lecturer.create(name: FFaker::Name.name, lecturer_id: lecturer_id, password: password, degree: degree, gender: gender,
                academic_title: academic_title, position: position, birthday: birthday, phone: phone, email: email, address: address)
      end

      lecturer = Lecturer.create(name: "Giang vien", lecturer_id: "GV001", password: "123456", degree: 0, gender: 1,
          academic_title: "academic_title", position: 1, birthday: "18/05/1994", phone: "0987676767", email: "email@gmail.com", address: "Nguyen luong bang")
      student = Student.create(name: "Sinh vieen 001", student_id: "SV001", password: "123456", gender: 1, curriculum_id: cur.id, student_class_id: student_class.id,
          birthday: "18/09/1993", phone: "0993824398402", email: "sinhvien@gmail.com", address: "Nguyen luong bang", second_language: "Anh van", course_id: course.id)
     
      puts "Create lecturer of subject"
      lecturer_subject = LecturerSubject.create(lecturer_id: lecturer.id, subject_id: subject1.id)

      puts "Create class subjects"
      class_subject = ClassSubject.create(class_subject_id: "LHP001", lecturer_subject_id: lecturer_subject.id, semester_id: sem.id)      
      bt = class_subject.scores.create(score_type: :exercise)
      dbt = bt.sub_scores.create(name: "BT", percent: 100) 
      gk = class_subject.scores.create(score_type: :mid_semester)
      dgk = gk.sub_scores.create(name: "GK", percent: 100) 
      ck = class_subject.scores.create(score_type: :end_semester)
      dck = ck.sub_scores.create(name: "CK", percent: 100) 
  
      puts "Create student of class subject"
      StudentClassSubject.create(class_subject_id: class_subject.id, student_id: student.id)
      StudentClassSubject.create(class_subject_id: class_subject.id, student_id: 1)
      StudentClassSubject.create(class_subject_id: class_subject.id, student_id: 2)
      StudentClassSubject.create(class_subject_id: class_subject.id, student_id: 3)
      StudentClassSubject.create(class_subject_id: class_subject.id, student_id: 4)
      StudentClassSubject.create(class_subject_id: class_subject.id, student_id: 5)
      StudentClassSubject.create(class_subject_id: class_subject.id, student_id: 6)
      
      puts "Create Class leader"
      ClassLeader.create(lecturer_id: lecturer.id, student_class_id: student_class.id)

      puts "Create scores of student"
      StudentSubScore.create(student_id: student.id, sub_score_id: dbt.id, score: 7)
      StudentSubScore.create(student_id: student.id, sub_score_id: dgk.id, score: 8)
      StudentSubScore.create(student_id: student.id, sub_score_id: dck.id, score: 9)
      
      6.times do |i|
        StudentSubScore.create(student_id: i+1, sub_score_id: dbt.id, score: 6)
        StudentSubScore.create(student_id: i+1, sub_score_id: dgk.id, score: 8)
        StudentSubScore.create(student_id: i+1, sub_score_id: dck.id, score: 7)
      end
    end
  end
end