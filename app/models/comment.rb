class Comment < ApplicationRecord
  belongs_to :art
  belongs_to :user

  validates :content, presence:true
end
