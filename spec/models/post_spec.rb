require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'validations' do
    before do
      FactoryGirl.create(:post)
    end
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:content) }
    it { should validate_uniqueness_of(:title).scoped_to(:user_id).with_message('You can\'t have two posts with the same name') }
  end

  describe 'relations' do
    it { should belong_to(:user) }
    it { should belong_to(:category) }
    it { should have_many(:comments) }
  end
end
