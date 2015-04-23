module ApplicationHelper
  def markdown(content)
    @markdown ||= Redcarpet::Markdown
                  .new(Redcarpet::Render::HTML,
                       autolink: true, space_after_headers: true, tables: true,
                       fenced_code_blocks: true, quote: true, footnotes: true,
                       highlight: true, underline: true, strikethrough: true,
                       superscript: true)
    @markdown.render(content).html_safe
  end

  def time_parser(time)
    time.strftime('%Y %m %d %H:%M') if time
  end

  def controller_action(controller, action)
    params[:controller].sub(/.*\//, '') == controller && params[:action] == action
  end

  def controller?(*controllers)
    'active' if controllers.include?(params[:controller].sub(/.*\//, ''))
  end
end
