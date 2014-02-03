=begin
File.open(Rails.root.join("config", "data", "Classes.xml")) do |f|
  xml = Nokogiri::XML(f)

  SOCIAL_CLASSES = Hash.from_xml(xml.to_s)
end

OBLIGATIONS["Classes"]["Class"].each do |values|
  key = values["Key"]
  obligation = Obligation.where(key: key).first || Obligation.from_xml(values)
end
=end
