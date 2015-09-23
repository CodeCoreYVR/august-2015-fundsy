class Discussion < ActiveRecord::Base
  has_many :comments, dependent: :destroy, as: :commentable
end
