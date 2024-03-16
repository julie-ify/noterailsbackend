# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  has_many :notes

  validates :username, presence: true, uniqueness: true, length: { minimum: 3, maximum: 50 }

  validates :password, presence: true, length: { minimum: 6, maximum: 50 }

  enum role: %i[user admin]

  attribute :role, default: -> { 0 }
end
