module CharacterXml
  extend ActiveSupport::Concern

  def self.from_xml(xml)
    hash = Hash.from_xml(xml)
    character_params = {}

    description_hash = hash["Character"]["Description"]
    character_params[:name] = description_hash["CharName"]
    character_params[:player_name] = description_hash["PlayerName"]
    character_params[:gender] = description_hash["Gender"]
    character_params[:age] = description_hash["Age"]
    character_params[:height] = description_hash["Height"]
    character_params[:build] = description_hash["Build"]
    character_params[:hair] = description_hash["Hair"]
    character_params[:eyes] = description_hash["Eyes"]
    character_params[:notable_features] = description_hash["OtherFeatures"]

    social_class_key = hash["Character"]["Class"]["ClassKey"]
    background_key = hash["Character"]["Hook"]["HookKey"]

    character_params[:social_class] = SocialClass.lookup(social_class_key)
    character_params[:background] = Background.lookup(background_key)

    create(character_params)
  end

  def to_xml(options = {})
    require 'builder'
    options[:indent] ||= 2
    xml = options[:builder] ||= ::Builder::XmlMarkup.new(indent: options[:indent])
    xml.instruct! unless options[:skip_instruct]
    xml.tag!(:Character) do
      xml.tag!(:Description) do
        xml.tag!(:CharName, name)
        xml.tag!(:PlayerName, player_name)
        xml.tag!(:Gender, gender)
        xml.tag!(:Age, age)
        xml.tag!(:Height, height)
        xml.tag!(:Build, build)
        xml.tag!(:Hair, hair)
        xml.tag!(:Eyes, eyes)
        xml.tag!(:OtherFeatures, notable_features)
      end
      xml.tag!(:Characteristics) do
        self.characteristics.each do |ch|
          xml.tag!(:CharCharacteristic) do
            xml.tag!(:Key, ch.key)
            xml.tag!(:Name, ch.name)
            xml.tag!(:Description)
            xml.tag!(:Source)
            xml.tag!(:Custom, "Base")
            xml.tag!(:Rank) do
              xml.tag!(:StartingRanks, 0)
              xml.tag!(:SpeciesRanks, 0)
              xml.tag!(:CareerRanks, 0)
              xml.tag!(:TalentRanks, 0)
              xml.tag!(:ObligationRanks, 0)
              xml.tag!(:DutyRanks, 0)
              xml.tag!(:AttachRanks, 0)
              xml.tag!(:ItemRanks, 0)
              xml.tag!(:PurchasedRanks, 0)
              xml.tag!(:CharRanks, 0)
            end
          end
        end
      end
      xml.tag!(:Motivations) do
        xml.tag!(:CharMotivation) do
          xml.tag!(:Key, 0)
          xml.tag!(:Name, "Ambition")
          xml.tag!(:Description)
          xml.tag!(:Source)
          xml.tag!(:Custom, "Base")
          xml.tag!(:Notes)
          xml.tag!(:MotiveKey, "AMB")
          xml.tag!(:SpecMotiveKey, "WAND")
        end
      end
      xml.tag!(:Specializations) do
      end
      xml.tag!(:ForcePowers)
      xml.tag!(:SigAbilities)
      xml.tag!(:Skills) do
        self.character_skills.each do |cs|
          xml.tag!(:CharSkill) do
            xml.tag!(:Key, cs.skill.key)
            xml.tag!(:Name, cs.skill.name)
            xml.tag!(:Description)
            xml.tag!(:Source, cs.skill.source)
            xml.tag!(:Custom, "Base")
            xml.tag!(:Rank) do
              xml.tag!(:StartingRanks, 0)
              xml.tag!(:SpeciesRanks, 0)
              xml.tag!(:CareerRanks, 0)
              xml.tag!(:TalentRanks, 0)
              xml.tag!(:ObligationRanks, 0)
              xml.tag!(:DutyRanks, 0)
              xml.tag!(:AttachRanks, 0)
              xml.tag!(:ItemRanks, 0)
              xml.tag!(:PurchasedRanks, 0)
              xml.tag!(:CharRanks, 0)
            end
          end
        end
      end
      xml.tag!(:ObOptions) do
        xml.tag!(:StartingSize, self.obligation_options.starting_size)
        xml.tag!(:Plus5XP, self.obligation_options.plus_five_xp)
        xml.tag!(:Plus10XP, self.obligation_options.plus_ten_xp)
        xml.tag!(:Plus1000Cr, self.obligation_options.plus_thousand_credits)
        xml.tag!(:Plus2500Cr, self.obligation_options.plus_two_thousand_five_hundred_credits)
      end
      xml.tag!(:Obligations) do
        self.character_obligations.each_with_index do |co, i|
          xml.tag!(:CharObligation) do
            xml.tag!(:Key, i)
            xml.tag!(:Name, co.obligation.name)
            xml.tag!(:Description)
            xml.tag!(:Source)
            xml.tag!(:Custom, "Base")
            xml.tag!(:Notes, co.notes)
            xml.tag!(:ObKey, co.obligation.key)
          end
        end
      end
      xml.tag!(:DutOptions) do
        xml.tag!(:StartingSize, self.duty_options.starting_size)
        xml.tag!(:Plus5XP, self.duty_options.plus_five_xp)
        xml.tag!(:Plus10XP, self.duty_options.plus_ten_xp)
        xml.tag!(:Plus1000Cr, self.duty_options.plus_thousand_credits)
        xml.tag!(:Plus2500Cr, self.duty_options.plus_two_thousand_five_hundred_credits)
      end
      xml.tag!(:Duties) do
        self.character_duties.each_with_index do |cd, i|
          xml.tag!(:CharObligation) do
            xml.tag!(:Key, i)
            xml.tag!(:Name, cd.duty.name)
            xml.tag!(:Description)
            xml.tag!(:Source)
            xml.tag!(:Custom, "Base")
            xml.tag!(:Notes, cd.notes)
            xml.tag!(:ObKey, cd.duty.key)
          end
        end
      end
      xml.tag!(:Experience) do
        xml.tag!(:ExperienceRanks) do
          xml.tag!(:StartingRanks, 0)
          xml.tag!(:SpeciesRanks, self.starting_experience)
          xml.tag!(:CareerRanks, 0)
          xml.tag!(:TalentRanks, 0)
          xml.tag!(:ObligationRanks, 0)
          xml.tag!(:DutyRanks, 0)
          xml.tag!(:AttachRanks, 0)
          xml.tag!(:ItemRanks, 0)
          xml.tag!(:PurchasedRanks, self.earned_experience)
          xml.tag!(:CharRanks, 0)
        end
        xml.tag!(:UsedExperience, self.used_experience)
      end
      xml.tag!(:Attributes) do
        xml.tag!(:SoakValue) do
          xml.tag!(:StartingRanks, 0)
          xml.tag!(:SpeciesRanks, 0)
          xml.tag!(:CareerRanks, 0)
          xml.tag!(:TalentRanks, 0)
          xml.tag!(:ObligationRanks, 0)
          xml.tag!(:DutyRanks, 0)
          xml.tag!(:AttachRanks, 0)
          xml.tag!(:ItemRanks, 0)
          xml.tag!(:PurchasedRanks, 0)
          xml.tag!(:CharRanks, 0)
        end
        xml.tag!(:WoundThreshold) do
          xml.tag!(:StartingRanks, 0)
          xml.tag!(:SpeciesRanks, 0)
          xml.tag!(:CareerRanks, 0)
          xml.tag!(:TalentRanks, 0)
          xml.tag!(:ObligationRanks, 0)
          xml.tag!(:DutyRanks, 0)
          xml.tag!(:AttachRanks, 0)
          xml.tag!(:ItemRanks, 0)
          xml.tag!(:PurchasedRanks, 0)
          xml.tag!(:CharRanks, 0)
        end
        xml.tag!(:StrainThreshold) do
          xml.tag!(:StartingRanks, 0)
          xml.tag!(:SpeciesRanks, 0)
          xml.tag!(:CareerRanks, 0)
          xml.tag!(:TalentRanks, 0)
          xml.tag!(:ObligationRanks, 0)
          xml.tag!(:DutyRanks, 0)
          xml.tag!(:AttachRanks, 0)
          xml.tag!(:ItemRanks, 0)
          xml.tag!(:PurchasedRanks, 0)
          xml.tag!(:CharRanks, 0)
        end
        xml.tag!(:DefenseRanged) do
          xml.tag!(:StartingRanks, 0)
          xml.tag!(:SpeciesRanks, 0)
          xml.tag!(:CareerRanks, 0)
          xml.tag!(:TalentRanks, 0)
          xml.tag!(:ObligationRanks, 0)
          xml.tag!(:DutyRanks, 0)
          xml.tag!(:AttachRanks, 0)
          xml.tag!(:ItemRanks, 0)
          xml.tag!(:PurchasedRanks, 0)
          xml.tag!(:CharRanks, 0)
        end
        xml.tag!(:DefenseMelee) do
          xml.tag!(:StartingRanks, 0)
          xml.tag!(:SpeciesRanks, 0)
          xml.tag!(:CareerRanks, 0)
          xml.tag!(:TalentRanks, 0)
          xml.tag!(:ObligationRanks, 0)
          xml.tag!(:DutyRanks, 0)
          xml.tag!(:AttachRanks, 0)
          xml.tag!(:ItemRanks, 0)
          xml.tag!(:PurchasedRanks, 0)
          xml.tag!(:CharRanks, 0)
        end
        xml.tag!(:ForceRating) do
          xml.tag!(:StartingRanks, 0)
          xml.tag!(:SpeciesRanks, 0)
          xml.tag!(:CareerRanks, 0)
          xml.tag!(:TalentRanks, 0)
          xml.tag!(:ObligationRanks, 0)
          xml.tag!(:DutyRanks, 0)
          xml.tag!(:AttachRanks, 0)
          xml.tag!(:ItemRanks, 0)
          xml.tag!(:PurchasedRanks, 0)
          xml.tag!(:CharRanks, 0)
        end
      end
      xml.tag!(:Species) do
        xml.tag!(:SpeciesKey, self.species.key)
        xml.tag!(:SelectedOptions) do
          self.character_options.each do |option|
            xml.tag!(:CharOption) do
              xml.tag!(:ChoiceKey, option.choice_key)
              xml.tag!(:OptionKey, option.option_key)
              xml.tag!(:StartingChars) do
                xml.tag!(:Brawn, 1)
                xml.tag!(:Agility, 1)
                xml.tag!(:Intellect, 1)
                xml.tag!(:Cunning, 1)
                xml.tag!(:Willpower, 1)
                xml.tag!(:Presence, 1)
                xml.tag!(:Requirement) do
                  xml.tag!(:WearingArmor, false)
                  xml.tag!(:Career, false)
                  xml.tag!(:Specialization, false)
                  xml.tag!(:NonCareer, false)
                  xml.tag!(:SoakAtLeast, 0)
                end
              end
              xml.tag!(:StartingAttribs) do
                xml.tag!(:WoundThreshold, 0)
                xml.tag!(:StrainThreshold, 0)
                xml.tag!(:DefenseRanged, 0)
                xml.tag!(:DefenseMelee, 0)
                xml.tag!(:SoakValue, 0)
                xml.tag!(:Experience, 0)
                xml.tag!(:ForceRating, 0)
                xml.tag!(:Requirement) do
                  xml.tag!(:WearingArmor, false)
                  xml.tag!(:Career, false)
                  xml.tag!(:Specialization, false)
                  xml.tag!(:NonCareer, false)
                  xml.tag!(:SoakAtLeast, 0)
                end
              end
              xml.tag!(:StartingSkillTraining)
              xml.tag!(:SkillModifiers)
              xml.tag!(:TalentModifiers)
            end
          end
        end
      end
      xml.tag!(:Career) do
        xml.tag!(:CareerKey, self.career.key)
        xml.tag!(:StartingSpecKey, self.first_specialization.key)
        xml.tag!(:CareerSkills) do
          self.free_career_skill_ranks.each do |r|
            xml.tag!(:Key, r.character_skill.key)
          end
        end
        xml.tag!(:CareerSpecSkills) do
          self.free_specialization_skill_ranks.each do |r|
            xml.tag!(:Key, r.character_skill.key)
          end
        end
      end
      xml.tag!(:Class) do
        xml.tag!(:ClassKey, social_class.try(:slug))
      end
      xml.tag!(:Hook) do
        xml.tag!(:HookKey, background.try(:key))
      end
      xml.tag!(:Weapons) do
      end
    end
  end

end
