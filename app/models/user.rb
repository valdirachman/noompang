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

  has_many :posts, dependent: :destroy # remove a user's post if user is deleted
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy

  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  has_one :profile

  # helper methods

  # for creating empty profile
  def create_profile
    self.profile = Profile.create
  end

  # for sending message
  def mailboxer_email(object)
    nil
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
end
