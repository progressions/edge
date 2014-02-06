module Sourced
  include ActiveSupport::Concern

  def source
    self.read_attribute(:source) || "Edge of the Empire Rulebook"
  end
end
