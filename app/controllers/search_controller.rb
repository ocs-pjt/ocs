class SearchController < ApplicationController

  def search_export
    # TODO : should check eventually if params[:facets] is nil
    facets = Search.pre_process(params[:facets])

    if Search::SEARCH_TARGETS.keys.include?(resource_type = params[:resource_type].to_sym)
    # TODO : count if there are actually records to export
      unless (f = params[:first_records].blank?) && params[:last_records].blank?
        method = f ? :last : :first
        job_id = ExportsWorker.perform_async({facets: facets, resource_type: resource_type, user_id: current_user.id, method: method})
        InProgressTask.create(user_id: current_user.id, job_id: job_id)
      else
        render text: "TODO: Too many records"
      end
    else
      render text: "TODO: resource_type incorrect"
    end
  end


  def search

    # retrieve records from provided params

  end

end