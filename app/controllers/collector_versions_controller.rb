class CollectorVersionsController < ApplicationController
  before_action :authenticate_user! # Normal devise authentication
  before_action :set_collector_version, only: [:show]

  # GET /collectors/1
  # GET /collectors/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_collector_version
      @collector_version = CollectorVersion.find(params[:id])
    end
end