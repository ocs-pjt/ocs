class StatisticsController < ApplicationController

  def world
    @statistics = Statistic.includes(:user)

    world_stats = {}

    @statistics.each do |stat|
      nb_permutations = stat.stats['nb_permutations']
      country_code = stat.user.country_code
      world_stats[country_code] = world_stats[country_code].to_i + nb_permutations.to_i if country_code
    end

    render json: world_stats.to_json
  end


end