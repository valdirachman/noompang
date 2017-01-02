class Post < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  validates :from, presence: true, length: { maximum: 50 } # assuming place consists of maximum 50 chars
  validates :destination, presence: true, length: { maximum: 50 } # assuming place consists of maximum 50 chars
  validates :date, presence: true
  validates :time, presence: true
  default_scope -> { order(created_at: :desc) } # newest posts first
  scope :friends, -> (friends) { where user_id: friends }
  scope :user, -> (user) { where user_id: user }
end
