# == Schema Information
#
# Table name: characters
#
#  id                    :integer          not null, primary key
#  name                  :string(255)
#  description           :text
#  user_id               :integer
#  created_at            :datetime
#  updated_at            :datetime
#  player_name           :string(255)
#  gender                :string(255)
#  age                   :string(255)
#  height                :string(255)
#  build                 :string(255)
#  hair                  :string(255)
#  eyes                  :string(255)
#  notable_features      :text
#  credits               :integer
#  used_experience       :integer
#  portrait_file_name    :string(255)
#  portrait_content_type :string(255)
#  portrait_file_size    :integer
#  portrait_updated_at   :datetime
#  story                 :text
#  social_class_id       :integer
#  background_id         :integer
#

class Character < ActiveRecord::Base
  belongs_to :user

  has_many :experience_ranks
  belongs_to :social_class
  belongs_to :background

  has_one :obligation_options
  accepts_nested_attributes_for :obligation_options

  has_many :character_obligations
  has_many :obligations, through: :character_obligations

  accepts_nested_attributes_for :character_obligations, allow_destroy: true
  accepts_nested_attributes_for :obligations

  has_attached_file :portrait, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/assets/:style/missing.jpg"
  validates_attachment_content_type :portrait, :content_type => /\Aimage\/.*\Z/

  before_save :update_obligation_xp
  before_save :update_obligation_credits

  def total_experience
    experience_ranks.sum(:amount).to_i + used_experience.to_i
  end

  def earned_experience_rank
    experience_ranks.where(source: :purchased).first || experience_ranks.create(source: :purchased, amount: 0)
  end

  def earned_experience
    earned_experience_rank.amount
  end

  def earned_experience=(amount)
    earned_experience_rank.update_attributes(amount: amount)
  end

  concerning :UpdatingObligationOptions do
    def update_obligation_credits
      amount = self.credits

      if obligation_options.changes["plus_thousand_credits"] == [false, true]
        amount += 1000
      elsif obligation_options.changes["plus_thousand_credits"] == [true, false]
        amount -= 1000
      end

      if obligation_options.changes["plus_two_thousand_five_hundred_credits"] == [false, true]
        amount += 2500
      elsif obligation_options.changes["plus_two_thousand_five_hundred_credits"] == [true, false]
        amount -= 2500
      end

      self.credits = amount
    end

    def update_obligation_xp
      amount = 0
      if obligation_options.plus_five_xp
        amount += 5
      end
      if obligation_options.plus_ten_xp
        amount += 10
      end
      obligation_rank.update_attribute(:amount, amount)
    end
  end

  concerning :Ranks do
    def obligation_rank
      experience_ranks.by_obligation.first || experience_ranks.build(source: "obligation")
    end
  end

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

    social_class_slug = hash["Character"]["Class"]["ClassKey"]
    background_slug = hash["Character"]["Hook"]["HookKey"]

    character_params[:social_class] = SocialClass.lookup(social_class_slug)
    character_params[:background] = Background.lookup(background_slug)

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
      xml.tag!(:Class) do
        xml.tag!(:ClassKey, social_class.slug)
      end
      xml.tag!(:Hook) do
        xml.tag!(:HookKey, background.slug)
      end
    end
  end

end
