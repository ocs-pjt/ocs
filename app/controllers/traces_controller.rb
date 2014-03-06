class TracesController < ApplicationController
  before_action :authenticate_user! # Normal devise authentication

  def index 
    @traces = Trace.includes(:additional_information).
                paginate(page: params[:page], per_page: 30).
                order(created_at: :desc) 
  end
end