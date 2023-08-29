RSpec.describe Like, type: :model do
  let(:user) { User.new(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'New user', posts_counter: 1) }
  let(:post) do
    Post.create(author: user, title: 'Nature', text: 'This is exciting!', likes_counter: 0, comments_counter: 0)
  end
  subject { Like.new(post:, user:) }

  before do
    post.save # Save the post object explicitly
    subject.save
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without a post' do
    subject.post = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without a user' do
    subject.user = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid if the user already liked the post' do
    expect(subject).to be_valid
    expect(subject.dup).to_not be_valid
  end
end
