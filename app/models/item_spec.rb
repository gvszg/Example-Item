class ItemSpec < ActiveRecord::Base
  scope :recent, -> {order(id: :DESC)}

  belongs_to :item

  # validates_presence_of :style, :style_amount
  validates_numericality_of :style_amount, :only_integer => true, :greater_than_or_equal_to => 0, :allow_blank => true

  mount_uploader :style_pic, SpecPicUploader
end