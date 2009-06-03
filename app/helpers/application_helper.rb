# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def tab_link(name, options)
    options[:page] = params[:page]
    content_tag(:li, link_to_unless_current(name, options) {content_tag(:span, name)})
  end
end
