class IndirectBooking < ActiveRecord::Base
  belongs_to :driver_post
  belongs_to :post
  belongs_to :user

  scope :accepted, -> { where(status: 1) }
  scope :rejected, -> { where(status: 2) }
  scope :pending, -> { where(status: 0) }
  scope :reserved, -> { where("status = ? OR status = ?", 0, 1) }
  
  def accept
    self.update(status: 1)
  end

  def reject
    self.update(status: 2)
  end
end
