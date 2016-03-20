# == Schema Information
#
# Table name: items
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  price      :integer          not null
#  image      :string(255)
#  slug       :string(255)
#  status     :integer          default(0)
#  deleted_at :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Item < ActiveRecord::Base
  scope :recent, -> { order(id: :DESC) }

  enum status: { disable: 0, enable: 1 }

  acts_as_paranoid

  has_many :photos
  has_many :item_categories
  has_many :categories, through: :item_categories

  # after_commit :remove_nil_of_image

  def default_photo
    photos.first.image.url
  end

  def intro_cover
    photos.first.image.medium.url
  end

  def remove_nil_of_image
    self.photos.each do |photo|
      photo.destroy if photo.image.blank?
    end
  end
end