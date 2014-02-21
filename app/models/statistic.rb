class Statistic < ActiveRecord::Base
  # setup hstore
  store_accessor :stats
  belongs_to :user

  # Recalculate every day the statistics of the user see config/schedule.rb
  def self.recalculate_stats
    User.includes(:statistic).each do |user|
      count_new_permutations = Permutation.where(already_handled: false).update_all(already_handled: true)
      count_new_traces = Trace.where(already_handled: false).update_all(already_handled: true)
      @statistic = user.statistic

      @statistic.stats['nb_permutations'] = user.statistic.stats['nb_permutations'].to_i + count_new_permutations
      @statistic.stats['nb_traces'] = user.statistic.stats['nb_traces'].to_i + count_new_traces
      @statistic.save! # Doesn't save in db yet. Bug : https://github.com/rails/rails/issues/6127?source=cc
    end
  end
end
