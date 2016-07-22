require 'rails_helper'

RSpec.describe AccessController, type: :controller do
  describe 'GET #login' do
    it 'returns http success' do
      get :login
      expect(response).to render_template(:login)
    end
  end

  describe 'POST #attempt_login' do
    context 'when user provides valid credentials' do
      user = FactoryGirl.create(:user)
      before do
        post :attempt_login, username: user.username, password: user.password
      end

      it 'puts username to session' do
        expect(session[:username]).to eq(user.username)
      end

      it "redirects to user's profile page" do
        expect(response).to redirect_to(controller: 'users',
                                        action: 'show',
                                        user_id: user)
      end
    end

    context 'when user provides invalid credentials' do
      before do
        post :attempt_login, username: 'incorrect', password: 'incorrect'
      end

      it 'redirects to the login page' do
        expect(response).to redirect_to(action: 'login')
      end

      it 'shows flash message for invalid credentials' do
        expect(flash[:error])
          .to include('Invalid username/password combination.')
      end
    end
  end
end
