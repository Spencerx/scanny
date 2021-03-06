module Scanny
  module Checks
    class FileOpenCheck < Check
      def pattern
        [
          pattern_file_open,
          pattern_fileutils
        ].join("|")
      end

      def check(node)
        issue :info, warning_message
      end

      def strict?
        true
      end

      private

      def warning_message
        "Operations on files in code can lead to" +
        "unauthorized access to data"
      end

      # File.open
      def pattern_file_open
        <<-EOT
          SendWithArguments<
            receiver = ConstantAccess<name = :File>,
            name = :open
          >
        EOT
      end

      # FileUtils.any_method
      def pattern_fileutils
        <<-EOT
          SendWithArguments<
            receiver = ConstantAccess<name = :FileUtils>
          >
        EOT
      end
    end
  end
end