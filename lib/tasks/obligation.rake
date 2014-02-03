namespace :obligations do
  task load: :environment do
    begin
      File.open(Rails.root.join("config", "data", "Obligations.xml")) do |f|
        xml = Nokogiri::XML(f)

        OBLIGATIONS = Hash.from_xml(xml.to_s)
      end

      OBLIGATIONS["Obligations"]["Obligation"].each do |values|
        key = values["Key"]
        obligation_values = {}
        values.each do |k, v|
          obligation_values[k.downcase] = v
        end
        obligation = Obligation.where(key: key).first || Obligation.create(obligation_values)

        puts "Created obligation: #{obligation.name}"
      end

    rescue StandardError => e
      puts e.message
    end
  end
end
