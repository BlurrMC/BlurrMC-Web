class Video < ApplicationRecord
    mount_uploader :clip, ::ClipUploader, mount_on: :clip
    process_in_background :clip
    
    searchkick 
    is_impressionable :unique => [:session_hash, :ip_address]
    scope :of_followed_users, -> (following_users) { where user_id: following_users }
    def search_data
    {
        description: description
    }
    end
    def next
        user.videos.where("id > ?", id).order("id ASC").first
    end
    
    def prev
        user.videos.where("id < ?", id).order("id DESC").first
    end

    belongs_to :user
    has_many :comments, dependent: :destroy, as: :commentable
    has_many :likes, dependent: :destroy
    has_many :video_hash_tags, dependent: :destroy
    has_many :hash_tags, through: :video_hash_tags

    #validates :clip, size: { less_than: 100.megabytes , message: 'must be under 100 MB' }
    # ​process_in_background :clip
    # store_in_background :clip

    validates_presence_of :clip
    before_destroy :destroy_clip
    after_commit :create_hash_tags, on: :create

    def destroy_clip
        self.clip.remove! if self.clip
        self.save!
    end

    def create_hash_tags
        extract_name_hash_tags.each do |name|
            hash_tags.create(name: name)
        end
    end

    def extract_name_hash_tags
        description.to_s.scan(/#\w+/).map{|name| name.gsub("#", "")}
    end
    
end
