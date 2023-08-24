require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  let(:user) { User.create(id: 1, name: 'reko', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'tester') }
  let(:post) { Post.create(id: 1, author_id: 1, title: 'Coding', text: ' Rails') }

  describe 'GET #index' do
    it 'responds with HTTP success' do
      get user_posts_path(user)
      expect(response).to have_http_status(:success)
    end

    it 'renders the index template' do
      get user_posts_path(user)
      expect(response).to render_template(:index)
    end

    it 'includes correct placeholder text in the response body' do
      get user_posts_path(user)
      expect(response.body).to include('All posts')
    end
  end

  describe 'GET #show' do
    it 'responds with HTTP success' do
      get user_post_path(user, post)
      expect(response).to have_http_status(:success)
    end
    it 'renders the show template' do
      get user_post_path(user, post)
      expect(response).to render_template(:show)
    end
    it 'includes correct placeholder text in the response body' do
      get user_post_path(user, post)
      expect(response.body).to include('Posts based on specific user')
    end
  end
end
