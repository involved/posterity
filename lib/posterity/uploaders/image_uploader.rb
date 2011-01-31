module Posterity
  module Uploaders
    module ImageUploader
      include CarrierWave::RMagick
      
      def self.included(base)
        base.extend(ClassMethods)
        base.storage :file
        
        base.version :large do
          process :resize_to_fill => [920, 600]
        end

        base.version :medium do
          process :resize_to_fill => [680, 400]
        end

        base.version :thumbnail do
          process :resize_to_fill => [360, 220]
        end

        base.version :square do
          process :resize_to_fill => [75, 75]
        end
      end
      
      def default_url
        "/images/#{model.class.to_s.underscore}/" + [version_name, "default.png"].compact.join('_')
      end

      def store_dir
        "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
      end

      def extension_white_list
        %w(jpg jpeg gif png)
      end
      
      module ClassMethods
        # nothing
      end
    end
  end
end