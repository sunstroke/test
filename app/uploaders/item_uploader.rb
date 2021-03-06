# encoding: utf-8

class ItemUploader < CarrierWave::Uploader::Base
include CarrierWave::MimeTypes
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick
  # after :store, :delete_old_tmp_file


  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{model.id}/#{mounted_as}_#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end
  # remember the tmp file
  def cache!(new_file)
    super
    @old_tmp_file = new_file
  end

  def delete_old_tmp_file(dummy)
    if @old_tmp_file.present?
      @old_tmp_file.try :delete
    end
  end
  # Process files as they are uploaded:
  process :resize_to_fit => [1000, 1000]  
  #process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end
  version :one_foto do
    process :resize_to_fit => [270, 325]
  end
  version :main_foto do
    process :resize_to_fit => [270, 215]
  end
  version :tumb_foto do
    process :resize_to_fit => [135, 110]
  end  
  # Create different versions of your uploaded files:
  # version :thumb do
  #   process :scale => [50, 50]
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_white_list
  #   %w(jpg jpeg gif png)
  # end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
