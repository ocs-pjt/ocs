class ResourcesController < ApplicationController
  before_action :authenticate_user! # Normal devise authentication

  def collect 
    if params[:object] && (data_type = params[:object][:data_type].to_s.downcase) && Search.target_keys.include?(data_type.to_sym)
      if params[:object].presence && params[:object][:data].presence
        if use_case = UseCase.find_by(key: params[:use_case_key].to_s.strip)
          ai = AdditionalInformation.create_from_params(params[:operating_system], params[:object], params[:deferred])
          data_type.camelize.constantize.insert(params[:object][:data], use_case, ai)
        else
          msg = "Usecase key invalid"
        end
      else
        msg = "No data to proceed"
      end
    else
      msg = "Data type incorrect"
    end

    msg ? render(json: { response: msg }.to_json, status: :ok) : render(nothing: true)
  end

end