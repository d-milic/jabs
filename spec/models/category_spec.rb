require 'rails_helper'

RSpec.describe Category, type: :model do
  before do
    FactoryGirl.create(:category)
  end
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
  end

  describe 'relations' do
    it { should have_many(:posts) }
    it { should belong_to(:parent_category).class_name('Category') }
    it { should have_many(:subcategories).class_name('Category') }
  end
end
