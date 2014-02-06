namespace :load do
  task all: [:backgrounds, :obligation, :social_class, :weapons]

  task backgrounds: :environment do
    Loader.load_from_xml("Background", filename: "Hooks", collection: "Hooks", member: "Hook")
  end
  task obligation: :environment do
    Loader.load_from_xml("Obligation")
  end
  task social_class: :environment do
    Loader.load_from_xml("SocialClass", filename: "Classes", collection: "Classes", member: "Class")
  end
  task weapons: :environment do
    Loader.load_from_xml("Weapon")
  end
end
