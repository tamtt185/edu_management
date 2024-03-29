class ClassSubjectTabs < Tabs
  private

  def tabs
    list_class_subject = []
    current_lecturer.lecturer_subjects.includes(:class_subjects, :subject).each do |lecturer_subject|
      lecturer_subject.class_subjects.each do |class_subject|
        name = class_subject.class_subject_id + " - " + lecturer_subject.subject.name
        path = lecturer_class_subject_path(class_subject)
        list_class_subject.push(build_tab(name, path, :class_subject))
      end
    end
    list_class_subject.compact
  end
end
