# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string(255)
#  password_digest :string(255)
#  guest           :boolean
#  created_at      :datetime
#  updated_at      :datetime
#

FactoryGirl.define do
  sequence :email do |n|
    "email#{n}@email.com"
  end

  factory :user do
    email
    password "password"
    password_confirmation "password"

    factory :guest do
      guest true
      email nil
      password nil
      password_confirmation nil
    end
  end
end
