class HomeController < ApplicationController  
  def index
    @collectors = ::Collector.all
    @collector_versions = @collectors.first.try(:collector_versions)  || []
  end
end
