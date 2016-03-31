# == Schema Information
#
# Table name: items
#
#  id          :integer          not null, primary key
#  name        :string(255)      not null
#  price       :integer          not null
#  slug        :string(255)
#  status      :integer          default(0)
#  deleted_at  :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  description :text(65535)
#

class Item < ActiveRecord::Base
  scope :recent, -> { order(id: :DESC) }

  scope :sort, -> { order(position: :ASC) }

  enum status: { on_shelf: 0, off_shelf: 1 }

  acts_as_paranoid

  self.per_page = 15

  has_many :photos, dependent: :destroy
  has_many :item_categories
  has_many :categories, through: :item_categories
  has_many :specs, class_name: "ItemSpec", dependent: :destroy

  mount_uploader :cover, ItemCoverUploader

  # 商品頁預設圖片
  # def default_photo
  #   photos.first
  # end

  # 封面圖
  def intro_cover
    cover
  end

  # def remove_nil_of_image
  #   self.photos.each do |photo|
  #     photo.destroy if photo.image.blank?
  #   end
  # end
end