class HomeController < ApplicationController
  skip_before_filter :authenticate_user! , only: [:index]
  
  def index
    @collectors = ::Collector.all
    @collector_versions = @collectors.first.try(:collector_versions)  || []
  end

end
