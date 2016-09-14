require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #show' do
    let(:user) { FactoryGirl.create(:user_with_posts) }
    before do
      get :show, username: user.username
    end

    it 'renders show template' do
      expect(response).to render_template('show')
    end

    it 'assigns user to template' do
      expect(assigns(:user)).to match(user)
    end

    it 'assigns posts to template' do
      expect(assigns(:posts)).to match(user.posts)
    end
  end
end
