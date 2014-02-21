class Trace < ActiveRecord::Base
  belongs_to :use_case

  facet :created_from, field_name: 'permutations.created_at', where: '>= {{value}}'
  facet :created_to, field_name: 'permutations.created_at', where: '<= {{value}}'
  facet :tag_ids, field_name: 'tags.id'

  def self.insert(items, use_case)
    time = Time.now
    inserts = []
    items.each do |h|
      inserts.push "('#{h['data']}', #{use_case.id}, '#{time}')"
    end
    sql = "INSERT INTO traces (data, use_case_id, created_at) VALUES #{inserts.join(", ")}"
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
