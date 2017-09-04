class User < ActiveRecord::Base
  # Initiating empty profile
  after_create :create_profile

  # Friend model for Relationship
  include Amistad::FriendModel

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  # For messaging functionality between users
  acts_as_messageable

  validates_presence_of :username
  validates_uniqueness_of :username

  has_many :posts, dependent: :destroy # remove a user's post if user is deleted
  has_many :driver_posts, dependent: :destroy
  has_many :direct_bookings, dependent: :destroy
  has_many :indirect_bookings, dependent: :destroy

  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy

  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  has_one :profile

  scope :not_friends, -> (current_user) { where user_id: friends }

  # helper methods
  # for Authentication social media
  has_many :authentications

  def apply_omniauth(omniauth)
    authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'])
  end

  def password_required?
    (authentications.empty? || !password.blank?) && super
  end
  # for creating empty profile
  def create_profile
    self.profile = Profile.create
  end

  # for sending message
  def mailboxer_email(object)
    nil
  end

  # for finding potential recommended_friends
  def self.find_not_friends(user)
    self.all.select { |r| (not user.invited? r) && (not r.friend_with? user) }
  end

  # follow another user
  def follow(other)
    active_relationships.create(followed_id: other.id)
  end

  # unfollow another user
  def unfollow(other)
    active_relationships.find_by(followed_id: other.id).destroy
  end

  # is following a user?
  def following?(other)
    following.include?(other)
  end

  def self.search(query)
    where("username like ?", "%#{query}%")
  end

  def has_notification
    self.pending_invited_by.count + DirectBooking.pending_of_user(self.id).count + IndirectBooking.pending_of_user(self.id).count > 0
  end

  def num_notification
    self.pending_invited_by.count + DirectBooking.pending_of_user(self.id).count + IndirectBooking.pending_of_user(self.id).count
  end
end
