# encoding: utf-8
module ApplicationHelper
  def identifier(string)
    string.to_s.underscore.gsub(/[^A-Za-z0-9]/, "")
  end

  def format_description(description)
    description = description.force_encoding("iso-8859-1").encode("utf-8")
    description.
      gsub("\n", "").
      gsub('\"', '"').
      gsub("[H4]", "<h4>").
      gsub("[h4]", "</h4>").
      gsub("[P]", "<p>").
      gsub("[p]", "</p>").
      gsub("[B]", "<strong>").
      gsub("[b]", "</strong>").
      gsub("[I]", "<em>").
      gsub("[i]", "</em>").
      html_safe
  rescue StandardError => e
    return e
  end
end
