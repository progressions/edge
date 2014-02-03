class Loader
  def self.load_from_xml(name)
    begin
      klass = name.constantize
      collection_name = name.pluralize

      File.open(Rails.root.join("config", "data", "#{collection_name}.xml")) do |f|
        xml = Nokogiri::XML(f)

        @hash = Hash.from_xml(xml.to_s)
      end

      @hash[collection_name][klass.name].each do |values|
        key = values["Key"]
        class_values = {}
        values.each do |k, v|
          class_values[k.downcase] = v
        end
        record = klass.where(key: key).first || klass.create(class_values)

        puts "Loaded record: #{record.inspect}"
      end
    rescue StandardError => e
      puts e.message
    end
  end
end
