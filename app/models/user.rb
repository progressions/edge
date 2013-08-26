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

class User < ActiveRecord::Base
  has_secure_password(validations: false)

  validates :password, confirmation: true, unless: :guest?
  validates :password, presence: true, on: :create, unless: :guest?
  validates :email, presence: true, unless: :guest?
  validates :email, uniqueness: true, unless: :guest?

  has_many :characters

  def self.new_guest
    new do |u|
      u.guest = true
    end
  end

  def move_to(user)
    characters.update_all(user_id: user.id)
  end

  def name
    if guest?
      "Guest"
    else
      email
    end
  end
end
