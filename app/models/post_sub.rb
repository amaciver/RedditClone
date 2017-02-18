class PostSub < ActiveRecord::Base
  validates_uniqueness_of :sub_id, scope: :post_id
  validates :sub, :post, presence: true

  belongs_to :sub

  belongs_to :post

end
