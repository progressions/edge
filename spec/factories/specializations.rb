# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :specialization do
    name "Specialization"
    career_skills ["Negotiation", "Resilience"]
    career_id 1
  end
end
