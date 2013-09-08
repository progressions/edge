namespace :careers do
  task load: :environment do
    Career.seed!
  end
end
