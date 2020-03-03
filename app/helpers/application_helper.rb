module ApplicationHelper
  def page_heading(title)
    render partial: 'helper_partials/page_heading', locals: {title: title}
  end

  def side_nav(*options)
    render partial: "helper_partials/side_nav", locals: {options: options}
  end

  def quick_options(*options, ajax: false)
    html = initiate_quick_options
    html += '<ul class="quick_options">'

    options << yield if block_given?
    options.each do |o|
      html += '<li>'
      html += link_to o[0], o[1], remote: ajax
      html += '</li>'
    end
    html += '</ul>'
    #html += '</div>'

    html.html_safe
  end

  def initiate_quick_options

    "<script>$(document).ready(function(){
        toggleClassOnHover('.quick_options li', 'quick_option_selected');
      })</script>"
  end
end
