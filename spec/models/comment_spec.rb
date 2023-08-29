require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) { User.new(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'New user', posts_counter: 1) }
  let(:post) do
    Post.new(author: user, title: 'Nature', text: 'This is exciting!', likes_counter: 0, comments_counter: 0)
  end
  subject { Comment.new(text: 'This is my comment', user:, post:) }
  before { subject.save }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end
end
