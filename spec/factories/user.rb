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
