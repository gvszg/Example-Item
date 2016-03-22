# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  def store_dir
    if Rails.env.production?
      "storage/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    elsif Rails.env.development?
      "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    end
  end
  
  # 預設圖片尺寸
  process resize_to_fit: [600, 600]
  
  # 封面圖片尺寸
  version :thumb do
    process resize_to_fill: [150,150]
  end

  # 商品介紹圖片尺寸
  version :medium do
    process resize_to_fill: [400,400]
  end
end