File.open(Rails.root.join("config", "data", "Obligations.xml")) do |f|
  xml = Nokogiri::XML(f)

  OBLIGATIONS = Hash.from_xml(xml.to_s)
end

OBLIGATIONS["Obligations"]["Obligation"].each do |values|
  key = values["Key"]
  obligation = Obligation.where(key: key).first || Obligation.from_xml(values)
end
