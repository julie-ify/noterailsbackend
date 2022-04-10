class Note < ApplicationRecord
  belongs_to :user

	validates :title, presence: true, length: { minimum: 3, maximum: 50 }

	validates :body, presence: true, length: { minimum: 3, maximum: 250 }
	
end
