class Search
  MAX_RECORDS = 10_000
  QUOTA_TASKS = 3

  SEARCH_TARGETS = {
    permutation: proc {
      Permutation.includes(use_case: [:tags])
    },
    trace: proc {
      Trace.includes(use_case: [:tags])
    }
  }

  def self.target_base(target)
    SEARCH_TARGETS[target].call
  end

  def self.to_csv(collection, options = {})
    # Check: Maybe a bug if the collection is empty, but I believe it is handled before this method is being called
    collection.first.class.to_csv(collection) 
  end

  # Clean up and formats facet params
  def self.pre_process(facets = {})
    # I shouldn't normally know the facets I am filtering from. But I still need to format date facets with the right format
    facets[:created_from] = DateTime.parse(facets[:created_from]).iso8601 rescue nil
    facets[:created_to] = DateTime.parse(facets[:created_to]).iso8601 rescue nil
    facets.delete_if {|key, value| value.blank? }
  end

  # Get records from search form params
  def self.perform(resource_type, facets, user_id, order_method, max_records)
    target_base(resource_type).
    find_by_facets(facets).
    where('use_cases.user_id' => user_id).
    __send__(order_method, max_records)
  end

end