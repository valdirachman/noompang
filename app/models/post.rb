class Post < ActiveRecord::Base
  belongs_to :user
  has_many :indirect_bookings, dependent: :destroy

  # For repost
  has_many :reposts, :foreign_key => "original_id", :class_name => "Post"
  belongs_to :original, :class_name => "Post"

  validates :user_id, presence: true
  validates :from, presence: true, length: { maximum: 50 } # assuming place consists of maximum 50 chars
  validates :destination, presence: true, length: { maximum: 50 } # assuming place consists of maximum 50 chars
  validates :date, presence: true
  validates :time, presence: true
  validates :note, length: { maximum: 100 } # assuming note consists of maximum 100 chars
  default_scope -> { order(date: :asc, time: :asc) } # yang waktunya paling awal
  scope :today, lambda { where("date >= ?", Time.zone.today) }
  scope :friends, -> (friends) { where user_id: friends }
  scope :self_and_friends, -> (ids) { where user_id: ids }

  def repost_by(reposter)
    if self.user == reposter
      "You can not repost your own ride"
    elsif self.reposts.find_by_user_id(reposter)
      "You have reposted this ride"
    else
      reposter.posts.build(from: self.from, destination: self.destination, date: self.date, note: self.note, time: self.time, original_id: self.id)
      reposter.save
      "Ride reposted"
    end
  end
end
