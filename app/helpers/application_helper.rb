module ApplicationHelper
  def identifier(string)
    string.to_s.underscore.gsub(/[^A-Za-z0-9]/, "")
  end
end
