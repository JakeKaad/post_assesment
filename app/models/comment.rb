class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  validates_presence_of :content
  default_scope {order('created_at DESC')}
end
