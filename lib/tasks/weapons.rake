namespace :weapons do
  task load: :environment do
    Loader.load_from_xml("Weapon")
  end
end
