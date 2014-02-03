BACKGROUNDS = HashWithIndifferentAccess.new(YAML.load(File.read(Rails.root.join("config", "backgrounds.yml"))))

BACKGROUNDS.each do |key, values|
  social_class = Background.where(name: values[:name]).first || Background.create(values)
end

