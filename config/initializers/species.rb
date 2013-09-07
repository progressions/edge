SPECIES = HashWithIndifferentAccess.new(YAML.load(File.read(Rails.root.join("config", "species.yml"))))
