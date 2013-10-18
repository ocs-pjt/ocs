class CollectorsController < ApplicationController

  def index
    @collectors = ::Collector.all
  end


end