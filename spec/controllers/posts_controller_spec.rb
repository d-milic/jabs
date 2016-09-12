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
    before do
      get :new
    end

    it 'renders new template' do
      expect(response).to render_template('new')
    end

    it 'assigns empty post object to instant variable' do
      expect(assigns(:post)).to be_a_new(Post)
    end

    it 'assigns all categories to template' do
      categories = FactoryGirl.create_list(:category, 5)
      categories.sort! { |x, y| x.name <=> y.name }
      expect(assigns(:categories)).to match(categories)
    end
  end

  describe 'POST #create' do
    before do
      post_params = FactoryGirl.attributes_for(:post)
      post :create, title: post_params[:title], content: post_params[:content],
                    category_id: post_params[:category_id]
    end
    it 'creates a new post' do
      expect.to change(Post, :count).by(1)
    end

    it 'redirects to the new post' do

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
