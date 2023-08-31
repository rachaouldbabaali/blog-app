class Comment < ApplicationRecord
  belongs_to :post, foreign_key: 'post_id'
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'

  after_save :comments_update
  after_destroy :decrement_post_comment_counter

  validates :text, presence: true, length: { maximum: 1000 }

  def decrement_post_comment_counter
    post.decrement!(:comments_counter)
  end

  private

  def comments_update
    post.increment!(:comments_counter)
  end
end
