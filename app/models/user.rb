class User < ApplicationRecord
  devise :two_factor_authenticatable, :two_factor_backupable,
          otp_backup_code_length: 10, otp_number_of_backup_codes: 10,
         :otp_secret_encryption_key => ENV['OTP_SECRET_KEY']
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :registerable,
         :recoverable, :rememberable, :validatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  searchkick word_start: [:username]

  # Two Factor Authentication
  serialize :otp_backup_codes, JSON
  attr_accessor :otp_plain_backup_codes
  

  def search_data
    {
      username: username,
      name: name
    }
  end


  devise :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :trackable


  acts_as_token_authenticatable

  attr_accessor :login

  extend FriendlyId

  has_one_attached :avatar, dependent: :destroy
  has_one :c, dependent: :destroy

  friendly_id :username, use: :slugged
  
  has_many :notifications, foreign_key: :recipient_id, dependent: :destroy
  has_many :reports, foreign_key: :recipient_id, dependent: :destroy
  has_many :badges, dependent: :destroy
  
  has_many :likes, dependent: :destroy
  has_many :videos, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :commentlikes, dependent: :destroy

  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :active_blocks, class_name: "Block", foreign_key: "blocker_id", dependent: :destroy
  has_many :passive_blocks, class_name: "Block", foreign_key: "blocked_id", dependent: :destroy

  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :blocking, through: :active_blocks, source: :blocked
  has_many :blockers, through: :passive_blocks, source: :blocker

  
  # Two Factor Authentication Functions

  # Generate OTP secret if it's missing
  def generate_two_factor_secret_if_missing!
    return unless otp_secret.nil?
    update!(otp_secret: User.generate_otp_secret)
  end

  def enable_two_factor!
    update!(otp_required_for_login: true)
  end

  def disable_two_factor!
    update!(
        otp_required_for_login: false,
        otp_secret: nil,
        otp_backup_codes: nil)
  end

  def two_factor_qr_code_uri
    issuer = ENV['OTP_2FA_ISSUER_NAME']
    label = [issuer, email].join(':')

    otp_provisioning_uri(label, issuer: issuer)
  end

  def two_factor_backup_codes_generated?
    otp_backup_codes.present?
  end


  def reported?(other)
    reports.include?(other)
  end

  def block(other)
    active_blocks.create(blocked_id: other.id)
  end

  def unblock(other)
    active_blocks.find_by(blocked_id: other.id).destroy
  end

  def blocking?(other)
    blocking.include?(other)
  end

  def follow(other)
    active_relationships.create(followed_id: other.id)
  end

  def unfollow(other)
    active_relationships.find_by(followed_id: other.id).destroy
  end

  def following?(other)
    following.include?(other)
  end


  def self.find_for_database_authentication warden_conditions
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    where(conditions).where(["lower(username) = :value OR lower(email) = :value", {value: login.strip.downcase}]).first
  end


  validates :avatar, attached: false,
                     content_type: ['image/png', 'image/jpg', 'image/jpeg', 'image/gif', message: 'Avatar must be a supported format' ],
                     size: { less_than: 2.megabytes , message: 'must be under 2mb' }

  validates :bio, length: {maximum: 50}
  validates :email, presence: true, 'valid_email_2/email': { mx: true, disposable: true, message: 'this email is not valid!', blacklist: true }


  def optimizeavatar
    return if self.has_attribute?(:avatar)
    return unless self.attachment_changes['avatar']

    path = self.attachment_changes['avatar'].attachable.tempfile.path
    image_optim = ImageOptim.new(:nice => 20, :pngout => true)
    image_optim.optimize_image_data(path)
    
    Clamby.safe?(path)
  end


  before_save :scan_for_viruses, :optimizeavatar
  
  protected


# Attempt to find a user by it's email. If a record is found, send new
# password instructions to it. If not user is found, returns a new user
# with an email not found error.
  def self.send_reset_password_instructions attributes = {}
    recoverable = find_recoverable_or_initialize_with_errors(reset_password_keys, attributes, :not_found)
    recoverable.send_reset_password_instructions if recoverable.persisted?
    recoverable
  end


  def self.find_recoverable_or_initialize_with_errors required_attributes, attributes, error = :invalid
    (case_insensitive_keys || []).each {|k| attributes[k].try(:downcase!)}

    attributes = attributes.slice(*required_attributes)
    attributes.delete_if {|_key, value| value.blank?}

    if attributes.keys.size == required_attributes.size
      if attributes.key?(:login)
        login = attributes.delete(:login)
        record = find_record(login)
      else
        record = where(attributes).first
      end
    end

    unless record
      record = new

      required_attributes.each do |key|
        value = attributes[key]
        record.send("#{key}=", value)
        record.errors.add(key, value.present? ? error : :blank)
      end
    end
    record
  end

  def self.find_record login
    where(["username = :value OR email = :value", {value: login}]).first
  end

  private

  def scan_for_viruses
    
  end
end
