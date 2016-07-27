require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #show' do
    user = FactoryGirl.create(:user)
    before do
      post :show, user_id: user.id
    end
    it 'renders show template' do
      expect(response).to render_template('show')
    end
    it 'assigns user to template' do
      expect(assigns(:user)).to match(user)
    end
  end
end
