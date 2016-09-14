require 'rails_helper'

RSpec.describe PostsController, type: :controller do

  let(:test_post)  { FactoryGirl.create(:post) }

  describe 'GET #show' do
    before do
      get :show, user_username: test_post.user.username, title: test_post.title
    end

    it 'renders show template' do
      expect(response).to render_template('show')
    end

    it 'assigns post to local instance variable' do
      expect(assigns(:post)).to match(test_post)
    end
  end

  describe 'GET #new' do
    before do
      get :new, nil, user_id: test_post.user_id
    end

    it 'renders new template' do
      expect(response).to render_template('new')
    end

    it 'assigns empty post object to instant variable' do
      expect(assigns(:post)).to be_a_new(Post)
    end

    it 'assigns all categories to template' do
      categories = FactoryGirl.create_list(:category, 5)
      categories.push(test_post.category)
      categories.sort! { |x, y| x.name <=> y.name }
      expect(assigns(:categories)).to match(categories)
    end
  end

  describe 'POST #create' do
    context 'when the parameters are valid' do
      it 'creates a new post' do
        expect do
          post :create, { post: FactoryGirl.attributes_for(:post) },
               user_id: test_post.user_id
        end.to change(Post, :count).by(2) # This counts test_post
      end

      it 'redirects to the new post' do
        post_attributes = FactoryGirl.attributes_for(:post)
        title = post_attributes[:title]
        post :create, { post: post_attributes },
             user_id: test_post.user_id
        expect(response).to redirect_to(
          "/users/#{test_post.user.username}/posts/#{title}"
        )
      end
    end
  end

  describe 'GET #edit' do
    before do
      get :edit, user_username: test_post.user.username, title: test_post.title
    end

    it 'renders edit template' do
      expect(response).to render_template('edit')
    end

    it 'assigns post to instance variable' do
      expect(assigns(:post)).to match(test_post)
    end
  end

end
