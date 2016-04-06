# encoding: utf-8

class SpecPicUploader < CarrierWave::Uploader::Base
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
  process resize_to_fit: [150, 150]
end