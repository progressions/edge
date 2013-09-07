namespace :species do
  task load: :environment do
    SPECIES.values.each do |attributes|
      species = Species.where(name: attributes["name"]).first || Species.create(attributes)
    end
  end
end
