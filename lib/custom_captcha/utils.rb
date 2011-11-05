module CustomCaptcha
  module Utils
    class << self
      def clear_all_image_files
        FileUtils.rm_r Dir[File.join(image_file_dirname(), "**", "*")]
      end

      def generate_image_file_path(text)
        File.join(
          image_file_dirname(),
          [image_file_basename_prefix(), image_file_basename_suffix(text), image_file_extname()].join()
        )
      end

    end

    private
      class << self
        def image_file_dirname
          CustomCaptcha::Configuration.images_path_definite
        end

        def image_file_basename_prefix
          ("a".."z").to_a.sort_by!{rand()}.take(6).join()
        end

        def image_file_basename_suffix(text)
          Digest::MD5.hexdigest(text)
        end

        def image_file_extname
          ".gif"
        end
      end
  end
end

