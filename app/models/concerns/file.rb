module Concerns
  module File
    extend ActiveSupport::Concern

    class InstanceMethods 
      def filename
        File.basename(self.file.path)
      end

      def url
        self.file.url
      end
    end
  end
end