class Topic < ActiveRecord::Base
  has_many :posts, dependent: :destroy

  # The following default_scope was added by the discretion of Jeff
  default_scope { order('created_at DESC') }

  validates :name, length: { minimum: 5 }, presence: true
  validates :description, length: { minimum: 15 }, presence: true
end
