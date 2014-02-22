module UpdatingSpecies
  extend ActiveSupport::Concern

  def species_option_for_choice(choice)
    self.character_options.where(choice_key: choice.key).first.try(:option)
  end

  def set_species_option(value)
    option = Option.find(value)
    choice = option.option_choice
    opt = self.character_options.where(choice_key: choice.key).first
    opt ||= self.character_options.build(choice_key: choice.key)
    opt.character_species_id = self.character_species.id
    opt.option_key = option.key
    opt.save!
  end

  def species_option=(value)
    set_species_option(value)
    clear_species_skill_ranks
    update_species_skills
  end
end
