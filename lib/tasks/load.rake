require 'loader'

namespace :load do
  task all: [:backgrounds, :obligation, :social_class, :weapons, :vehicles]

  task backgrounds: :environment do
    Loader.load_from_file("Background", filename: "Hooks", collection: "Hooks", member: "Hook")
  end
  task obligation: :environment do
    Loader.load_from_file("Obligation")
  end
  task social_class: :environment do
    Loader.load_from_file("SocialClass", filename: "Classes", collection: "Classes", member: "Class")
  end
  task weapons: :environment do
    Loader.load_from_file("Weapon")
  end
  task vehicles: :environment do
    Loader.load_from_files("Vehicle")
  end
end
