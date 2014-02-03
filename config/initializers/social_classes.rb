begin
  SOCIAL_CLASSES = HashWithIndifferentAccess.new(YAML.load(File.read(Rails.root.join("config", "social_classes.yml"))))

  SOCIAL_CLASSES.each do |key, values|
    social_class = SocialClass.where(name: values[:name]).first || SocialClass.create(values)
  end
rescue StandardError => e
end
