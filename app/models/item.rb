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

  enum status: { on_shelf: 0, off_shelf: 1 }

  acts_as_paranoid

  has_many :photos, dependent: :destroy
  has_many :item_categories
  has_many :categories, through: :item_categories
  has_many :specs, class_name: "ItemSpec", dependent: :destroy

  # 商品頁預設圖片
  def default_photo
    photos.first
  end

  def intro_cover
    photos.first.image.medium.url if self.photos.any?
  end

  def remove_nil_of_image
    self.photos.each do |photo|
      photo.destroy if photo.image.blank?
    end
  end
end