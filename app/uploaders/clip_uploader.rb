class ClipUploader < CarrierWave::Uploader::Base
  include CarrierWave::Backgrounder::Delay
  include CarrierWave::Video
  include CarrierWave::Video::Thumbnailer
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  #storage :file
  if Rails.env.production?
    storage :fog
  else
    storage :file
  end

  def filename
    if original_filename
      if model && model.read_attribute(mounted_as).present?
        model.read_attribute(mounted_as)
      else
        "#{secure_token}.#{file.extension}" if original_filename.present?
      end
    end
  end

  version :thumb do
    process thumbnail: [{format: 'png', quality: 8, size: 500, strip: false, logger: Rails.logger, seek: '1%'}]
    #process resize_to_fill: [200, 200]
    process :fix_content_type
    def full_filename for_file
      png_name for_file, version_name
    end
  end

  # Fix the content type for the thumbnail
  def fix_content_type
    file.content_type = 'image/png' if file
  end


  def png_name for_file, version_name
    %Q{#{version_name}_#{for_file.chomp(File.extname(for_file))}.png}
  end


  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
   "uploads/#{model.class.to_s.underscore}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url(*args)
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process scale: [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process resize_to_fit: [50, 50]
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_whitelist
    %w(mp4 mov m4a m4v avi mkv webm)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

  process encode_video: [
    :mp4,
    video_codec: "libx264",
    video_bitrate: 3000,
    video_bitrate_tolerance: 100,
    x264_vprofile: "main",
    x264_preset: "medium",
    threads: 2,
    duration: 7,
    audio_bitrate: 40000
  ]

  protected

  def secure_token
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.uuid)
  end
end
