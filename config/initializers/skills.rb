SKILLS = HashWithIndifferentAccess.new(YAML.load(File.read(Rails.root.join("config", "skills.yml"))))
