class Loader
  def self.load_single(klass, values)
    key = values["Key"]
    class_values = {}

    values.each do |k, v|
      next unless v.present?

      k = k.to_s.underscore
      if k == "type"
        k = "#{klass.name.underscore}_type"
      end

      case k
      when "categories"
        k = "categories_from_xml"
        v = v["Category"]
      when "attributes"
        k = "attributes_from_xml"
      when "specializations"
        k = "specializations_from_xml"
        v = v["Key"]
      when "option_choices"
        k = "option_choices_from_xml"
        v = v["OptionChoice"]
      when "options"
        k = "options_from_xml"
        v = v["Option"]
      when "starting_skill_training"
        k = "starting_skill_training_from_xml"
        v = v["SkillTraining"]
      when "career_skills"
        k = "skill_keys"
        v = v["Key"]
      when "skill_modifiers"
        k = "skill_modifiers_from_xml"
        v = v["SkillModifier"]
      when "addlHP"
        k = "additional_hp"
      end

      class_values[k] = v
    end

    class_values.select! do |k,v|
      klass.new.respond_to?("#{k}=".to_sym)
    end

    if klass.unique_key? && klass.new.respond_to?(:key)
      record = klass.where(key: key).first || klass.new
    else
      record = klass.new
    end
    record.update_attributes(class_values)

    puts "Loaded record: #{record.inspect}"

    record
  end

  def self.load_from_files(name, options={})
    path = Rails.root.join("config", "data", name.underscore.pluralize, "*")
    Dir[path].each do |path|
      @hash = Loader.get_hash_from_file(path)
      Loader.load_single(name.constantize, @hash[name])
    end
  end

  def self.get_hash_from_file(path)
    File.open(path) do |f|
      xml = Nokogiri::XML(f)

      @hash = Hash.from_xml(xml.to_s)
    end

    @hash
  end

  def self.load_from_file(name, options={})
    options ||= {}
    begin
      klass = options[:klass] || name.constantize
      member_name = options[:member] || klass.name
      collection_name = options[:collection] || name.pluralize

      filename = options[:filename] || collection_name
      path = options[:path] || Rails.root.join("config", "data", "#{filename}.xml")

      File.open(path) do |f|
        xml = Nokogiri::XML(f)

        @hash = Hash.from_xml(xml.to_s)
      end

      @hash[collection_name][member_name].each do |values|
        Loader.load_single(klass, values)
      end
    end
  end
end

class ActiveRecord::Base
  def self.unique_key?
    true
  end
end
