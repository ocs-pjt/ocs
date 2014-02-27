class StatisticsController < ApplicationController

  # Render user stats grouped by country_code
  def world
    @statistics = Statistic.includes(:user)

    world_stats = {}

    @statistics.each do |stat|
      count_permutations = stat.stats['permutations']
      country_code = stat.user.country_code
      world_stats[country_code] = world_stats[country_code].to_i + count_permutations.to_i if country_code
    end

    render json: world_stats.to_json
  end

  # Render user stats grouped by jvectormap state code (regions/states) for a given country_code
  def regions
    country_code = params[:country_code]
    @users = User.where(country_code: country_code).includes(:statistic)
  
    region_stats = {}

    @users.each do |user|
      if user.statistic
        count_permutations = user.statistic.stats['permutations']
        jvm_state_code = user.jvm_state_code(country_code, user.state)
        region_stats[jvm_state_code] = region_stats[jvm_state_code].to_i + count_permutations.to_i if jvm_state_code
      end
    end

    render json: region_stats.to_json
  end

end