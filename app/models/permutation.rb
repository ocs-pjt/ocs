class Permutation < ActiveRecord::Base
  belongs_to :use_case
  belongs_to :additional_information

  # TODO: Generation from the gem seem a bit clumsy though (to look at)
  facet :collection_point, where: %{
    EXISTS(
      SELECT *
      FROM additional_informations AS ai
      WHERE permutations.additional_information_id = ai.id
      ?
    )
  }.gsub(/\s+/, " ").strip

  facet :created_from, field_name: 'permutations.created_at', where: '>= {{value}}'
  facet :created_to, field_name: 'permutations.created_at', where: '<= {{value}}'
  facet :tag_ids, field_name: "tags.id"

  # # Not possible yet with the gem, would be better though
  # facet :last_records
  # facet :first_records

  # TODO : eventually create a table of the list of functions
  COLLECTION_POINTS = ["sort", "qsort", "mergesort"]

  def self.insert(items, use_case, additional_information)
    time = Time.now # Check for timezone
    inserts = []
    items.each do |value|
      inserts.push "('#{value}', #{use_case.id}, #{additional_information.id}, '#{time}')"
    end
    sql = "INSERT INTO permutations (data, use_case_id, additional_information_id, created_at) VALUES #{inserts.join(", ")}"
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

  # Get the list of collection_points (function names)
  def self.collection_points
    COLLECTION_POINTS
  end

  # Filter out these columns when exporting data
  def self.columns_to_remove
    ["id", "use_case_id", "created_at", "updated_at", "already_handled", "additional_information_id"]
  end
end
