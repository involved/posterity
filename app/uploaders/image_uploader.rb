class ImageUploader < CarrierWave::Uploader::Base
  include Posterity::Uploaders::ImageUploader
end
