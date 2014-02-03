namespace :backgrounds do
  task load: :environment do
    begin
      File.open(Rails.root.join("config", "data", "Hooks.xml")) do |f|
        xml = Nokogiri::XML(f)

        BACKGROUNDS = Hash.from_xml(xml.to_s)
      end

      BACKGROUNDS["Hooks"]["Hook"].each do |values|
        key = values["Key"]
        background_values = {}
        values.each do |k, v|
          background_values[k.downcase] = v
        end
        background = Background.where(key: key).first || Background.create(background_values)

        puts "Created background: #{background.name}"
      end

    rescue StandardError => e
      puts e.message
    end
  end
end


