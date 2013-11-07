class PermutationsController < ApplicationController

  def collect
    if use_case = UseCase.find_by(key: params[:use_case_key].strip)
      if collector = use_case.collector
        if collector_version = use_case.collector_version
          PermutationsWorker.perform_async({items: params[:items], use_case_id: use_case.id})
        else
          response = "Collector version invalid"
        end
      else
        response = "Collector name invalid"
      end
    else
      response = "Use Case key invalid"
    end
    
    respond_to do |format|
      format.json do
        render json: { response: response }.to_json, status: :ok
      end
    end
  end

end