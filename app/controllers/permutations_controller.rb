class PermutationsController < ApplicationController

  def collect
    response = "ok"

    if use_case = UseCase.find_by(key: params[:use_case_key].strip)
      if collector = use_case.collector
        unless collector_version = use_case.collector_version
          response = "Collector version invalid"
        end
      else
        response = "Collector name invalid"
      end
    else
      response = "Use Case key invalid"
    end
    
    if response == "ok"
      PermutationsWorker.perform_async({items: params[:items], use_case_id: use_case.id})
    end

    respond_to do |format|
      format.json do
        render json: { response: response }.to_json, status: :ok
      end
    end
  end

end