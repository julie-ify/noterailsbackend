require 'rails_helper'

RSpec.describe Note, type: :model do
  let!(:user) { User.create(username: 'testuser', password: 'password', age: '20') }
  let!(:note) { Note.create(title: '', body: 'This is note 1') }

  describe 'associations' do
    it { should belong_to(:user).class_name('User') }
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:body) }
		it { should validate_length_of(:title).is_at_least(3) }
  end
end