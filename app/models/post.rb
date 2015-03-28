class Post < ActiveRecord::Base
  has_many :comments
  belongs_to :user
  validates_presence_of :title, :content, :user_id
  default_scope { order('updated_at DESC') }
end
