CAREERS = HashWithIndifferentAccess.new(YAML.load(File.read(Rails.root.join("config", "careers.yml"))))
