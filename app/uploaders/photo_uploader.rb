# encoding: utf-8
class PhotoUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  version :normal do
    process resize_to_limit: [600, nil]
  end

  version :middle do
    process resize_to_limit: [400, nil]
  end

  version :small do
    process resize_to_limit: [280, nil]
  end

  version :thumb do
    process resize_to_fill: [120, 80]
  end   
  
  # def move_to_cache
  #   true
  # end
  # def move_to_store
  #   true
  # end  

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def filename 
    if original_filename 
      @name ||= Digest::MD5.hexdigest(File.dirname(current_path))
      "#{@name}.#{file.extension}"
    end
  end
end
