# == Schema Information
#
# Table name: users
#
#  id                           :integer          not null, primary key
#  email                        :string(255)
#  crypted_password             :string(255)
#  salt                         :string(255)
#  created_at                   :datetime
#  updated_at                   :datetime
#  remember_me_token            :string(255)
#  remember_me_token_expires_at :datetime
#

class User < ActiveRecord::Base
  has_secure_password

  validates :password, confirmation: true, unless: :guest?
  validates :password, presence: true, on: :create, unless: :guest?
  validates :email, presence: true, unless: :guest?
  validates :email, uniqueness: true, unless: :guest?

  has_many :characters

  def self.new_guest
    new do |u|
      u.guest = true
      u.email = "guest#{Date.today.to_s}@email.com"
      u.password = "password"
      u.password_confirmation = "password"
    end
  end
end
