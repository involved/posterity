# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base
  include Posterity::Uploaders::ImageUploader
end
