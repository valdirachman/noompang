class DriverPost < ActiveRecord::Base
  belongs_to :user
  has_many :direct_bookings, dependent: :destroy
  has_many :indirect_bookings, dependent: :destroy

  validates :user_id, presence: true
  validates :from, presence: true, length: { maximum: 50 } # assuming place consists of maximum 50 chars
  validates :destination, presence: true, length: { maximum: 50 } # assuming place consists of maximum 50 chars
  validates :date, presence: true
  validates :time, presence: true
  validates :note, length: { maximum: 100 } # assuming note consists of maximum 100 chars
  validates :price, presence: true
  validates :quantity, presence: true

  default_scope -> { order(date: :asc, time: :asc) } # yang waktunya paling awal
  scope :today, lambda { where("date >= ?", Time.zone.today) }
  scope :self_and_friends, -> (ids) { where user_id: ids }

  # Todo: add
  def available?
    self.quantity > self.direct_bookings.reserved.count + self.indirect_bookings.reserved.count
  end

  def available_seats
    self.quantity - (self.direct_bookings.reserved.count + self.indirect_bookings.reserved.count)
  end

  def reserved_by_user?(user_id)
    self.direct_bookings.reserved.where(user_id: user_id).exists? || self.indirect_bookings.reserved.where(user_id: user_id).exists?
  end

  def get_reserve_status_by_user(user_id)
    if self.direct_bookings.reserved.where(user_id: user_id).exists?
      self.direct_bookings.reserved.where(user_id: user_id).first.status
    else
      self.indirect_bookings.reserved.where(user_id: user_id).first.status
    end
  end
end
