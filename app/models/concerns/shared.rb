module Concerns
  module Shared
    extend ActiveSupport::Concern

    module ClassMethods
      def insert(items, use_case, additional_information)
        time = Time.now # Check for timezone
        inserts = []
        items.each do |value|
          inserts.push sanitize_sql_array(["(?, #{use_case.id}, #{additional_information.id}, '#{time}')", value]) 
        end
        sql = "INSERT INTO #{self.table_name} (data, use_case_id, additional_information_id, created_at) VALUES #{inserts.join(", ")}"
        ActiveRecord::Base.connection.execute sql
      end

      def to_csv(collection, options = {col_sep: ";"})
        CSV.generate(options) do |csv|
          real_column_names = column_names - columns_to_remove
          csv << real_column_names
          collection.each do |resource|
            csv << resource.attributes.values_at(*real_column_names)
          end
        end
      end

      # Filter out these columns when exporting data
      def columns_to_remove
        ["id", "use_case_id", "created_at", "updated_at", "already_handled", "additional_information_id"]
      end
    end

  end
end