class ViewObject
  attr_reader :context, :current_lecturer

  include Rails.application.routes.url_helpers
  include ActionView::Helpers
  include ActionView::Context
  
  # comment these two lines out if not using cancan
  include CanCan::ControllerAdditions
  delegate :current_ability, to: :context

  def initialize context, current_lecturer
    @context = context
    @current_lecturer = current_lecturer
  end
end
