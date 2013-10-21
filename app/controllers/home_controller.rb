class HomeController < ApplicationController
  def index
    @collectors = ::Collector.all
  end
end
