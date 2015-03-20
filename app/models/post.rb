class Post < ActiveRecord::Base 
  has_many :comments
  validates_presence_of :title, :content
  default_scope { order('updated_at DESC') }
end