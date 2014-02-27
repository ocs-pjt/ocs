class Statistic < ActiveRecord::Base
  # setup hstore
  store_accessor :stats
  belongs_to :user

  # Recalculate every day the statistics of the users (see config/schedule.rb)
  def self.recalculate_stats
    User.find_each do |user|
      # Update newly created permutations of specific user
      count_new_permutations = Permutation.joins(:use_case).
                                where(use_cases: {user_id: user.id}, already_handled: false).
                                update_all(already_handled: true)
      
      # Update newly created traces of specific user
      count_new_traces = Trace.joins(:use_case).
                            where(use_cases: {user_id: user.id}, already_handled: false).
                            update_all(already_handled: true)

      # Update newly created regular_expressions of specific user
      count_new_regular_expressions = RegularExpression.joins(:use_case).
                                        where(use_cases: {user_id: user.id}, already_handled: false).
                                        update_all(already_handled: true)

      # If one of the stats is above zero we initialize the statistic of that user or create a new one if none existed before
      if count_new_permutations > 0 || count_new_traces > 0 || count_new_regular_expressions > 0
        @statistic = Statistic.find_or_initialize_by(user_id: user.id)
        @statistic.stats = prepare_stats_data(@statistic.stats, count_new_permutations, count_new_traces, count_new_regular_expressions)
        @statistic.stats_will_change! # Needed for hstore fields otherwise rails dont update them. see : https://github.com/rails/rails/issues/6127?source=cc
        @statistic.save!
      end
    end
  end

  # Set the stats hstore field (dirty but couldn't find a better way of setting this hstore field)
  def self.prepare_stats_data(tmp_stats, count_new_permutations, count_new_traces, count_new_regular_expressions)
    # stats is nil at initialization maybe should be initialized at empty {} or add defaul value {} for hstore field
    user_stats = tmp_stats || {}
    user_stats['permutations']         = user_stats['permutations'].to_i         + count_new_permutations        if count_new_permutations > 0
    user_stats['traces']               = user_stats['traces'].to_i               + count_new_traces              if count_new_traces > 0
    user_stats['regular_expressions']  = user_stats['regular_expressions'].to_i  + count_new_regular_expressions if count_new_regular_expressions > 0  
    user_stats
  end
end
