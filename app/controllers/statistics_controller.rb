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


  def regions
    country_code = params[:country_code]
    @users = User.where(country_code: country_code).includes(:statistic)
  
    region_stats = {}

    @users.each do |user|
      nb_permutations = user.statistic.stats['nb_permutations']
      jvm_state_code = user.jvm_state_code(country_code, user.state)
      region_stats[jvm_state_code] = region_stats[jvm_state_code].to_i + nb_permutations.to_i if jvm_state_code
    end

    render json: region_stats.to_json
  end

end