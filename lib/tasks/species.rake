namespace :species do
  task load: :environment do
    Seed.load!
  end
end