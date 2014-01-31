class Search
  
  MAX_RECORDS = 50_000

  SEARCH_TARGETS = {
    permutation: proc {
      Permutation.includes(use_case: [:tags])
    }
  }

  def self.target_base(target)
    SEARCH_TARGETS[target].call
  end


  def self.to_csv(collection, options = {})
    collection.first.class.to_csv(collection, options = {}) 
  end

  def self.pre_process(facets = {})
    # I should normally not know the facets I am filtering from. But I still need to format date facets with the right format
    facets[:created_from] = DateTime.parse(facets[:created_from]).iso8601 rescue nil
    facets[:created_to] = DateTime.parse(facets[:created_to]).iso8601 rescue nil
    facets.delete_if {|key, value| value.blank? }
  end

end