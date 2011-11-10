module CustomCaptcha
  module CommonMethods
    private
      def object_field_tag_name(object_name, field_name)
        object_name.to_s + "[" + field_name.to_s + "]"
      end

      def object_field_tag_id(object_name, field_name)
        object_name.to_s + "_" + field_name.to_s
      end
  end
end

