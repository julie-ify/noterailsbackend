require 'rails_helper'

RSpec.describe Note, type: :model do

  describe 'associations' do
    it { should belong_to(:user).class_name('User') }
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }
		it { should validate_length_of(:title).is_at_least(3) }
		it { should validate_length_of(:title).is_at_most(50) }
		
    it { should validate_presence_of(:body) }
		it { should validate_length_of(:body).is_at_least(3) }
		it { should validate_length_of(:body).is_at_most(250) }
  end
end