module ApplicationHelper
  def identifier(string)
    string.to_s.underscore.gsub(/[^A-Za-z0-9]/, "")
  end

  def format_description(description)
    description.
      gsub("[H4]", "<h4>").
      gsub("[h4]", "</h4>").
      gsub("[P]", "<p>").
      gsub("[p]", "</p>").
      gsub("[B]", "<strong>").
      gsub("[b]", "</strong>").
      gsub("[I]", "<em>").
      gsub("[i]", "</em>").
      html_safe
  end
end
