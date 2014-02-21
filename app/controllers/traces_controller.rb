class TracesController < ApplicationController
  before_action :authenticate_user! # Normal devise authentication
  
  def collect
    if params[:items].presence
      if use_case = UseCase.find_by(key: params[:use_case_key].strip)
        Trace.insert(params['items'], use_case)
      else
        response = "Usecase key invalid"
      end
    else
      response = "No data to proceed"
    end

    if response
      render json: { response: response }.to_json, status: :ok
    else
      render nothing: true
    end
  end

end