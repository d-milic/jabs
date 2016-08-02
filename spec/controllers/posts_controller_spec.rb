require 'rails_helper'

RSpec.describe PostsController, type: :controller do

  let(:post)  { FactoryGirl.create(:post) }

  describe 'GET #show' do
    before do
      get :show, user_id: post.user_id, post_id: post.id
    end

    it 'renders show template' do
      expect(response).to render_template('show')
    end

    it 'assigns post to local instance variable' do
      expect(assigns(:post)).to match(post)
    end
  end

  describe 'GET #new' do
    it 'renders new template' do
      get :new
      expect(response).to render_template('new')
    end
  end

  describe 'GET #edit' do
    before do
      get :edit, user_id: post.user_id, post_id: post.id
    end

    it 'renders edit template' do
      expect(response).to render_template('edit')
    end

    it 'assigns post to instance variable' do
      expect(assigns(:post)).to match(post)
    end
  end

end
