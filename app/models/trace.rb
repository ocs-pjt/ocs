class Trace < ActiveRecord::Base
  belongs_to :use_case
  belongs_to :additional_information

  facet :created_from, field_name: 'permutations.created_at', where: '>= {{value}}'
  facet :created_to, field_name: 'permutations.created_at', where: '<= {{value}}'
  facet :tag_ids, field_name: 'tags.id'

  def self.insert(items, use_case, additional_information)
    time = Time.now # Check for timezone
    inserts = []
    items.each do |value|
      inserts.push "('#{value}', #{use_case.id}, #{additional_information.id}, '#{time}')"
    end
    sql = "INSERT INTO traces (data, use_case_id, additional_information_id, created_at) VALUES #{inserts.join(", ")}"
    ActiveRecord::Base.connection.execute sql
  end

  def self.to_csv(collection, options = {})
    CSV.generate(options) do |csv|
      real_column_names = self.column_names - ["id", "use_case_id", "created_at", "updated_at", "already_handled"]
      csv << real_column_names
      collection.each do |resource|
        csv << resource.attributes.values_at(*real_column_names)
      end
    end
  end

end
