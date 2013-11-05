class PermutationsController < ApplicationController

  def collect
    response = "ok"

    unless collector = ::Collector.find_by(name: params[:collector_name])
          && CollectorVersion.find_by(version: params[:collector_version], collector_id: collector.id)
      response = "Collector invalid"
    end

    unless use_case = UseCase.find_by(key: params[:use_case_key])
      response = "Use Case key invalid"
    end

    if response == "ok"  
      tags = use_case.joined_tags

      Permutation.collection.insert(params[:items]) do |p|
        p.email             = params[:email] # this param is safe (see application_controller.rb)
        p.collector_name    = use_case.collector.name
        p.collector_version = use_case.collector_version.version
        p.program           = use_case.program_name
        p.program_version   = use_case.program_version_version
        p.tags              = tags
      end
    end
    
    respond_to do |format|
      format.json do
        render json: { response: response }.to_json, status: :ok
      end
    end
  end

end