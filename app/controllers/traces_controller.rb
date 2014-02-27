class TracesController < ApplicationController
  before_action :authenticate_user! # Normal devise authentication
  
  def collect
    if params[:object].presence && params[:object][:data].presence
      if use_case = UseCase.find_by(key: params[:use_case_key].strip)
        additional_information = AdditionalInformation.create!(
          operating_system: params[:operating_system],
          collection_point: params[:object][:collection_point],
          optional:         params[:object][:optional],
          description:      params[:object][:description],
          deferred_date:    params[:deferred] && params[:deferred][:date],
          postman_name:     params[:deferred] && params[:deferred][:postman_name],
          postman_version:  params[:deferred] && params[:deferred][:postman_version]
        )
        Trace.insert(params[:object][:data], use_case, additional_information)
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