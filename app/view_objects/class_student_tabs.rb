class ClassStudentTabs < Tabs
  private

  def tabs
    list_class_student = []
    current_lecturer.student_classes.each do |student_class|
      name = student_class.name
      path = lecturer_student_class_path(student_class)
      list_class_student.push(build_tab(name, path, :student_class))
    end
    list_class_student.compact
  end
end
