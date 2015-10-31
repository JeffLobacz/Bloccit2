class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user

  # The following default_scope was added by the discretion of Jeff
  default_scope { order('created_at DESC') }

  validates :body, length: { minimum: 5 }, presence: true
  validates :user, presence: true
end
