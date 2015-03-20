class Comment < ActiveRecord::Base
  belongs_to :post
  validates_presence_of :content
  default_scope {order('created_at DESC')}
end