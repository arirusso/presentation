module Presentation

  module Element

    module HasID

      def id
        @id ||= HasID.uuid
      end

      def self.uuid
        @last_id += 1
      end

    end

  end

end
