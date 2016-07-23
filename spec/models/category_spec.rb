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
  end
end
