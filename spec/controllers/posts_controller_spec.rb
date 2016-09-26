require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  before :all do
    @test_post = FactoryGirl.create(:post)
  end
  
  describe 'GET #show' do
    before do
      get :show, user_username: @test_post.user, title: @test_post
    end

    it 'renders show template' do
      expect(response).to render_template('show')
    end

    it 'assigns post to local instance variable' do
      expect(assigns(:post)).to match(@test_post)
    end
  end

  describe 'DELETE #destroy' do
    context 'when the parameters are valid' do
      it 'should delete the post' do
        expect do
          delete :destroy, user_username: @test_post.user, title: @test_post
        end.to change(Post, :count).by(-1)
      end
    end
  end

  describe 'GET #new' do
    before do
      get :new, nil, user_id: @test_post.user_id
    end

    it 'renders new template' do
      expect(response).to render_template('new')
    end

    it 'assigns empty post object to instant variable' do
      expect(assigns(:post)).to be_a_new(Post)
    end

    it 'assigns all categories to template' do
      categories = FactoryGirl.create_list(:category, 5)
      categories.push(@test_post.category)
      categories.sort! { |x, y| x.name <=> y.name }
      expect(assigns(:categories)).to match(categories)
    end
  end

  describe 'POST #create' do
    context 'when the parameters are valid' do
      it 'creates a new post' do
        expect do
          post :create, { post: FactoryGirl.attributes_for(:post) },
               user_id: @test_post.user_id
        end.to change(Post, :count).by(1)
      end

      it 'redirects to the new post' do
        post_attributes = FactoryGirl.attributes_for(:post)
        title = post_attributes[:title]
        post :create, { post: post_attributes },
             user_id: @test_post.user_id
        expect(response).to redirect_to(
          "/users/#{@test_post.user.username}/posts/#{title}"
        )
      end
    end

    context 'when the parameters are invalid' do
      before do
        post :create, { post: FactoryGirl.attributes_for(:invalid_post) },
             user_id: @test_post.user_id
      end
      it 'shows a message about invalid parameters' do
        expect(flash[:error]).to include('There was an error saving this post. Check if all the fields are filled out.')
      end

      it 'redirects back to the new post page' do
        expect(response).to redirect_to("/users/#{@test_post.user.username}/posts/new")
      end
    end
  end

  describe 'GET #edit' do
    before do
      get :edit, user_username: @test_post.user.username, title: @test_post.title
    end

    it 'renders edit template' do
      expect(response).to render_template('edit')
    end

    it 'assigns post to instance variable' do
      expect(assigns(:post)).to match(@test_post)
    end
  end

  describe 'GET #update' do
    let(:fixed_title_post) { FactoryGirl.create(:fixed_title_post) }
    context 'when the parameters are valid' do
      before do
        @updated_attributes = FactoryGirl
                              .attributes_for(:updated_fixed_title_post)
        patch :update, { post: @updated_attributes,
                         title: fixed_title_post.title },
              user_id: fixed_title_post.user_id
        fixed_title_post.reload
      end

      it 'should update the post' do
        expect(fixed_title_post.content).to eq(@updated_attributes[:content])
      end

      it 'should redirect to the edited post' do
        expect(response).to redirect_to(
          "/users/#{fixed_title_post.user.username}/posts/#{fixed_title_post.title}"
        )
      end
    end

    context 'when the parameters are invalid' do
      before do
        @valid_attributes = FactoryGirl.attributes_for(:fixed_title_post)
        @invalid_attributes = FactoryGirl.attributes_for(:invalid_post)
        patch :update, { post: @invalid_attributes,
                         title: fixed_title_post.title },
              user_id: fixed_title_post.user_id
      end
      it 'shows a message about invalid parameters' do
        expect(flash[:error]).to include('There was an error updating this post. Check if all the fields are filled out.')
      end

      it 'redirects back to the new post page' do
        expect(response).to redirect_to("/users/#{fixed_title_post.user.username}/posts/#{fixed_title_post.title}/edit")
      end
    end
  end
end
