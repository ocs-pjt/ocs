class RegularExpression < ActiveRecord::Base
  belongs_to :use_case
  belongs_to :additional_information

  facet :created_from, field_name: 'regular_expressions.created_at', where: '>= {{value}}'
  facet :created_to, field_name: 'regular_expressions.created_at', where: '<= {{value}}'
  facet :tag_ids, field_name: 'tags.id'

  def self.insert(items, use_case, additional_information)
    time = Time.now # Check for timezone
    inserts = []
    items.each do |value|
      inserts.push "('#{value}', #{use_case.id}, #{additional_information.id}, '#{time}')"
    end
    sql = "INSERT INTO regular_expressions (data, use_case_id, additional_information_id, created_at) VALUES #{inserts.join(", ")}"
    ActiveRecord::Base.connection.execute sql
  end

  def self.to_csv(collection, options = {col_sep: ";"})
    CSV.generate(options) do |csv|
      real_column_names = column_names - columns_to_remove
      csv << real_column_names
      collection.each do |resource|
        csv << resource.attributes.values_at(*real_column_names)
      end
    end
  end

  # Filter out these columns when exporting data
  def self.columns_to_remove
    ["id", "use_case_id", "created_at", "updated_at", "already_handled", "additional_information_id"]
  end


end
