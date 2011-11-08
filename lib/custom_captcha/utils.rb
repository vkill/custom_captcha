module CustomCaptcha
  module Utils

    mattr_reader :image_files_key
    @@image_files_key = {}

    class << self
      def clear_all_image_files
        FileUtils.rm_r Dir[File.join(image_file_dirname(), "**", "*")]
      end

      def generate_image_files(number=1, &block)
        CustomCaptcha::Image.create(number, &block)
      end

      def reload_all_image_files_key
        @@image_files_key.clear
        reset_image_files_key()
        @@image_files_key
      end
      alias_method :init_image_files_key, :reload_all_image_files_key

      def choice_image_file_key_by_rand
        reset_image_files_key()
        @@image_files_key.keys.sort_by!{rand()}.first
      end

      def get_image_file_path_by_key(image_file_key)
        @@image_files_key[image_file_key]
      end

      def generate_captcha_digested(image_file_key)
        image_file_path = get_image_file_path_by_key(image_file_key)
        image_file_basename = File.basename(image_file_path, image_file_extname())
        image_file_basename[-32..-1]
      end

      def valid_captcha_value(input_value, captcha_digested)
        image_file_basename_suffix(input_value) == captcha_digested
      end

    end

    private
      class << self
        def hexdigest_text(text)
          Digest::MD5.hexdigest([text, CustomCaptcha::Configuration.salt].join())
        end

        def image_file_dirname
          CustomCaptcha::Configuration.images_path_definite
        end

        def image_file_basename_prefix
#          ("a".."z").to_a.sort_by!{rand()}.take(8).join()
          SecureRandom.hex(4)
        end

        def image_file_basename_suffix(text)
          hexdigest_text(text)
        end

        def image_file_basename(text)
          [image_file_basename_prefix, image_file_basename_suffix(text)].join()
        end

        def image_file_extname
          ".gif"
        end

        # if image file path empty, then auto generating 3 image file.
        def reset_image_files_key
          if @@image_files_key.blank?
            n = 0
            while true
              @image_files = Dir[File.join(image_file_dirname(), ["[a-z0-9]*", image_file_extname()].join())]
              break unless @image_files.blank?
              generate_image_files(1)
              raise InitImageFilesKeyError if n >= 5
              n += 1
            end
            @image_files.each do |file|
              @@image_files_key[hexdigest_text([Time.now.to_i, SecureRandom.hex(10)].join())] = file
            end
          end
        end
      end
  end
end

