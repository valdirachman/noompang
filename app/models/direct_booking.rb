class DirectBooking < ActiveRecord::Base
  belongs_to :driver_post
  belongs_to :user

  scope :accepted, -> { where(status: 1) }
  scope :rejected, -> { where(status: 2) }
  scope :pending, -> { where(status: 0) }
  scope :reserved, -> { where("status = ? OR status = ?", 0, 1) }

  scope :pending_of_user, -> (user_id) { joins(:driver_post).where(driver_posts: {user_id: user_id}).pending }

  def accept
    self.update(status: 1)
  end

  def reject
    self.update(status: 2)
  end
end
