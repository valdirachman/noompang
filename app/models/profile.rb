class Profile < ActiveRecord::Base
  belongs_to :user

  def is_nil?
    return self.name.nil? && self.occupation.nil? && self.occupation_place.nil? && self.description.nil?
  end

  def is_empty?
    return self.name.empty? && self.occupation.empty? && self.occupation_place.empty? && self.description.empty?
  end
end
