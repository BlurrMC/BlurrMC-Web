class HashTag < ApplicationRecord
    has_many :video_hash_tags, dependent: :destroy
    has_many :videos, through: :video_hash_tags
end
