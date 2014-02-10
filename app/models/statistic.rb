class Statistic < ActiveRecord::Base
  # setup hstore
  store_accessor :stats

  belongs_to :user

  def self.recalculate_stats
    # Recalculate every now and then the statistics of the user
    
  end
end
