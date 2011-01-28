# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :s3

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
  
  version :large do
    process :resize_to_fill => [920, 600]
  end
    
  version :medium do
    process :resize_to_fill => [680, 400]
  end
  
  version :thumbnail do
    process :resize_to_fill => [360, 220]
  end
  
  version :square do
    process :resize_to_fill => [75, 75]
  end
  
  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
