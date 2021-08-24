class VideoHashTag < ApplicationRecord
    belongs_to :video
    belongs_to :hash_tag
end
