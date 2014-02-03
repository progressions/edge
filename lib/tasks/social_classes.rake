namespace :social_classes do
  task load: :environment do
    Loader.load_from_xml("SocialClass", filename: "Classes", collection: "Classes", member: "Class")
  end
end

