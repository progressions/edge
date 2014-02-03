namespace :backgrounds do
  task load: :environment do
    Loader.load_from_xml("Background", filename: "Hooks", collection: "Hooks", member: "Hook")
  end
end


