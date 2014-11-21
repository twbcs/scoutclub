module ApplicationHelper
  def markdown(content)
    @markdown ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML,
            autolink: true, space_after_headers: true, fenced_code_blocks: true,
            quote: true, footnotes: true, highlight: true, underline: true,
            strikethrough: true, tables: true, superscript: true )
    @markdown.render(content).html_safe
  end

  def time_parser(time)
    if time
      time.strftime("%Y %m %d %H:%M")
    end
  end
end
