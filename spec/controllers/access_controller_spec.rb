require 'rails_helper'

RSpec.describe AccessController, type: :controller do
  describe 'GET #login' do
    it 'returns http success' do
      get :login
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #attempt_login' do
    context 'when user provides the valid credentials' do
      # Arrange
      before do
        User.create(username: 'test',
                    password: 'test1',
                    email: 'mail@mail.mail')
      end
      it 'puts username to session' do
        # Act
        post :attempt_login, username: 'test', password: 'test1'
        # Assert
        expect(session[:username]).to eq('test')
      end

      it "redirects to user's profile page" do
      end
    end
  end
end
