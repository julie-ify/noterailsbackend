class User < ApplicationRecord
  has_secure_password

	has_many :notes

	validates :username, presence: true, uniqueness: true, length: { minimum: 3,
	too_short: "%{username} characters is the minimum allowed" }

	validates :password, presence: true, length: { minimum: 3, maximun: 50,
	too_long: "%{password} characters is the maximum allowed" }
end
