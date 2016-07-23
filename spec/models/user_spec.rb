require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    before do
      FactoryGirl.create(:user)
    end

    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }

    it { should validate_uniqueness_of(:username) }
    it { should validate_uniqueness_of(:email) }
  end

  describe 'relations' do
    it { should have_many(:posts) }
    it { should have_many(:comments) }
  end

  describe 'security' do
    it { should have_secure_password }
  end
end
