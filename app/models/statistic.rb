class Statistic < ActiveRecord::Base
  # setup hstore
  store_accessor :stats
  belongs_to :user

  # Recalculate every day the statistics of the user see config/schedule.rb
  def self.recalculate_stats
    User.includes(:statistic).find_each do |user|
      count_new_permutations = Permutation.where(already_handled: false).update_all(already_handled: true)
      count_new_traces = Trace.where(already_handled: false).update_all(already_handled: true)
      count_new_regular_expressions = RegularExpression.where(already_handled: false).update_all(already_handled: true)

      @statistic = user.statistic

      @statistic.stats['permutations'] = @statistic.stats['permutations'].to_i + count_new_permutations
      @statistic.stats['traces'] = @statistic.stats['traces'].to_i + count_new_traces
      @statistic.stats['regular_expressions'] = @statistic.stats['regular_expressions'].to_i + count_new_regular_expressions

      @statistic.stats_will_change! # Needed for hstore fields otherwise rails dont update them. see : https://github.com/rails/rails/issues/6127?source=cc
      @statistic.save!
    end
  end
end
