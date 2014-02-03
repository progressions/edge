module ApplicationHelper
  def identifier(string)
    string.to_s.underscore.gsub(/[^A-Za-z0-9]/, "")
  end

  def format_description(description)
    description.gsub("[H4]", "<h4>").gsub("[h4]", "</h4>").html_safe
  end
end
