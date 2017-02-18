class Comment < ActiveRecord::Base
  validates :content, :author, :post, presence: true

  belongs_to :author,
    foreign_key: :user_id,
    class_name: :User

  belongs_to :post

  belongs_to :parent_comment,
    foreign_key: :parent_comment_id,
    class_name: :Comment


end
