module ApplicationHelper
  def full_title page_title
    base_title = "DUT-IT"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def index_for counter, page, per_page
    (page - 1) * per_page + counter + 1
  end

  def show_index current_page, index
    current_page * 30 - 30 + index + 1
  end

  def link_to_remove_fields f
    f.hidden_field(:_destroy) + link_to(raw("<span class='glyphicon glyphicon-remove'></span>"),
      "#", onclick: "remove_fields(this)")
  end

  def link_to_add_fields f, association
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, child_index: "new_#{association}") do |builder|
      render association.to_s.singularize + "_fields", f: builder
    end
    link_to "Thêm cột điểm", "#", onclick: h("add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")")
  end

  def get_name_of_subject subject_id
    Subject.find_by(id: subject_id).name if Subject.find_by(id: subject_id)
  end
end 