class Permutation < ActiveRecord::Base
  include Concerns::Shared

  belongs_to :use_case
  belongs_to :additional_information

  # TODO: It works but the generation from the gem seems a bit clumsy though (to look at)
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

  # Get the list of collection_points (function names)
  def self.collection_points
    COLLECTION_POINTS
  end
end
