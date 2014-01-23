class Search
  
  MAX_RECORDS = 50_000

  SEARCH_TARGETS = {
    permutation: proc {
      Permutation.includes(:use_case)
    }
  }

  def self.target_base(target)
    SEARCH_TARGETS[target].call
  end


  def self.to_csv(collection, options = {})
    collection.first.class.to_csv(collection, options = {})
  end

end