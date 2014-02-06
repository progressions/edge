class Loader
  def self.load_single(klass, values)
    key = values["Key"]
    class_values = {}

    values.each do |k, v|
      next unless v.present?

      k = k.underscore
      if k == "type"
        k = "#{klass.name.underscore}_type"
      end

      if k == "categories"
        k = "categories_from_xml"
        v = v["Category"]
      end

      class_values[k] = v
    end

    class_values.select! do |k,v|
      klass.new.respond_to?("#{k}=".to_sym)
    end

    record = klass.where(key: key).first || klass.new
    record.update_attributes(class_values)

    puts "Loaded record: #{record.inspect}"
  end

  def self.load_from_xml(name, options={})
    options ||= {}
    begin
      klass = options[:klass] || name.constantize
      member_name = options[:member] || klass.name
      collection_name = options[:collection] || name.pluralize

      filename = options[:filename] || collection_name

      File.open(Rails.root.join("config", "data", "#{filename}.xml")) do |f|
        xml = Nokogiri::XML(f)

        @hash = Hash.from_xml(xml.to_s)
      end

      @hash[collection_name][member_name].each do |values|
        Loader.load_single(klass, values)
      end
    end
  end
end
