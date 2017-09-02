class Profile < ActiveRecord::Base
  belongs_to :user

  # For user's avatar
  has_attached_file :avatar,
    #url: "/system/:class/:attachment/:id/:style_:filename",
    styles: { medium: "120x120#", thumb: "60x60#" ,large: "200x200#"},
    default_url: "/images/avatar_:style.png"
  validates_attachment :avatar, content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] }
  validates_with AttachmentSizeValidator, attributes: :avatar, less_than: 5.megabytes

  def is_nil?
    return self.name.nil? && self.occupation.nil? && self.occupation_place.nil? && self.description.nil? && self.address.nil? && self.hobby.nil? && self.age.nil? && self.gender.nil? && self.university.nil? && self.major.nil? && self.about.nil?
  end

  def is_empty?
    return self.name.empty? && self.occupation.empty? && self.occupation_place.empty? && self.description.empty? && self.address.empty? && self.hobby.empty? && self.age.empty? && self.gender.empty? && self.university.empty? && self.major.empty? && self.about.empty?
  end
end
