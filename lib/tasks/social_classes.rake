namespace :social_classes do
  task load: :environment do
    begin
      File.open(Rails.root.join("config", "data", "Classes.xml")) do |f|
        xml = Nokogiri::XML(f)

        SOCIAL_CLASSES = Hash.from_xml(xml.to_s)
      end

      SOCIAL_CLASSES["Classes"]["Class"].each do |values|
        key = values["Key"]
        social_class_values = {}
        values.each do |k, v|
          social_class_values[k.downcase] = v
        end
        social_class = SocialClass.where(key: key).first || SocialClass.create(social_class_values)

        puts "Created social_class: #{social_class.name}"
      end

    rescue StandardError => e
      puts e.message
    end
  end
end

