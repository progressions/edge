require 'loader'

namespace :obligations do
  task load: :environment do
    Loader.load_from_xml("Obligation")
  end
end
