class Permutation < ActiveRecord::Base
  belongs_to :use_case

  facet :function
  facet :created_from, field_name: 'permutations.created_at', where: '>= {{value}}'
  facet :created_to, field_name: 'permutations.created_at', where: '<= {{value}}'
  facet :tag_ids, field_name: 'tags.id'

  # # Not possible yet with the gem, would be better though
  # facet :last_records
  # facet :first_records

  # TODO : eventually create a table of the list of functions
  FUNCTIONS = ["sort", "qsort", "mergesort"]

  def self.insert(items, use_case)
    time = Time.now
    inserts = []
    items.each do |h|
      inserts.push "('#{h['data']}', '#{h['function']}', #{use_case.id}, '#{time}')"
    end
    sql = "INSERT INTO permutations (data, function, use_case_id, created_at) VALUES #{inserts.join(", ")}"
    ActiveRecord::Base.connection.execute sql
  end

  # def self.to_csv(options = {})
  #   CSV.generate(options) do |csv|
  #     csv << self.column_names 
  #     all.each do |permutation|
  #       csv << permutation.attributes.values_at(*self.column_names)
  #     end
  #   end
  # end

  def self.to_csv(collection, options = {})
    CSV.generate(options) do |csv|
      real_column_names = self.column_names - ["id", "use_case_id", "created_at", "updated_at", "already_handled"]
      csv << real_column_names
      collection.each do |resource|
        csv << resource.attributes.values_at(*real_column_names)
      end
    end
  end

  def self.function_names
    FUNCTIONS
  end
end
