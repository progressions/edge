def seed_species
  SPECIES.values.each do |attributes|
    Species.create(attributes)
  end
end
