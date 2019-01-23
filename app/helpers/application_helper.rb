module ApplicationHelper
  def show_errors object, field_name
    if object.errors.any?
      str = "<ul class='gr-validation-errors'>"
      object.errors.full_messages_for(field_name).uniq.each do |message|
        str += "<li class='gr-validation-error-message'>#{message}</li>"
      end
      str += "</ul>"

      str.html_safe
    end
  end
end
