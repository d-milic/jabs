require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  before :all do
    @test_post = FactoryGirl.create(:post)
    @commenter = FactoryGirl.create(:user)
  end
  describe 'POST #create' do
    context 'when comment content is present' do
      before do
        @comment_attributes =
          FactoryGirl.attributes_for(:comment, post_id: @test_post.id)
      end

      it 'creates a new comment' do
        expect do
          post :create, { comment: @comment_attributes },
               user_id: @test_post.user_id
        end.to change(Comment, :count).by(1)
      end

      it 'redirects to the post with the new comment' do
        post :create, { comment: @comment_attributes },
             user_id: @test_post.user_id
        expect(response).to redirect_to(
          "/users/#{@test_post.user.username}/posts/#{@test_post.title}"
        )
      end
    end

    context 'when comment content is empty' do
      before do
        @invalid_comment_attributes =
          FactoryGirl.attributes_for(:invalid_comment, post_id: @test_post.id)
        post :create, { comment: @invalid_comment_attributes },
             user_id: @test_post.user_id
      end

      it 'shows a message about invalid parameters' do
        expect(flash[:error]).to include('There was an error saving this comment. Did you provide the content?')
      end

      it 'redirects to the show post page' do
        expect(response).to redirect_to(
          "/users/#{@test_post.user.username}/posts/#{@test_post.title}"
        )
      end
    end
  end
end
