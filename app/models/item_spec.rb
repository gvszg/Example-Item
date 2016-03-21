class ItemSpec < ActiveRecord::Base
  scope :recent, -> {order(id: :DESC)}

  belongs_to :item

  validates_presence_of :style, :style_amount

  mount_uploader :style_pic, SpecPicUploader
end