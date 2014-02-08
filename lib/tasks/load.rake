require 'loader'

namespace :load do
  task all: [:backgrounds, :obligation, :social_class, :weapons, :vehicles, :species, :specializations, :careers, :skills]

  task backgrounds: :environment do
    Loader.load_from_file("Background", filename: "Hooks", collection: "Hooks", member: "Hook")
  end
  task duty: :environment do
    Loader.load_from_file("Duty")
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
  task species: :environment do
    Loader.load_from_files("Species")
  end
  task careers: :environment do
    Loader.load_from_files("Career")
  end
  task specializations: :environment do
    Loader.load_from_files("Specialization")
  end
  task skills: :environment do
    Loader.load_from_file("Skill")
  end
end
