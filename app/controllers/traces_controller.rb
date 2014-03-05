class TracesController < ApplicationController
  before_action :authenticate_user! # Normal devise authentication

  def index 
    @traces = Trace.includes(:additional_information).
                paginate(page: params[:page], per_page: 30).
                order(created_at: :desc) 
  end
  
  def collect
    if params[:object].presence && params[:object][:data].presence
      if use_case = UseCase.find_by(key: params[:use_case_key].strip)
        ai = AdditionalInformation.create_from_params(params[:operating_system], params[:object], params[:deferred])
        Trace.insert(params[:object][:data], use_case, ai)
      else
        msg = "Usecase key invalid"
      end
    else
      msg = "No data to proceed"
    end

    if msg
      render json: { response: msg }.to_json, status: :ok
    else
      render nothing: true
    end
  end

end