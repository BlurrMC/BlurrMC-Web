class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  belongs_to :user
  has_many :commentlikes, dependent: :destroy
  belongs_to :parent, class_name: "Comment", optional: true
  has_many :replies,
           class_name: "Comment", foreign_key: :parent_id, dependent: :destroy
  scope :is_parent, -> {
    where(parent_id: nil)
  }
  scope :is_child, -> {
    where("parent_id IS NOT NULL")
  }
end
