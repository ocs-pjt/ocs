class SearchController < ApplicationController

  def search_export
    # Check if user is over the maximum of tasks he can make
    if InProgressTask.where(user_id: current_user.id).count < Search::QUOTA_TASKS 
      # TODO : should check eventually if params[:facets] is nil
      facets = Search.pre_process(params[:facets])

      if Search::SEARCH_TARGETS.keys.include?(resource_type = params[:resource_type].to_sym)
      # TODO : count if there are actually records to export
        unless (f = params[:first_records].blank?) && params[:last_records].blank?
          method = f ? :last : :first
          job_id = ExportsWorker.perform_async({facets: facets, resource_type: resource_type, user_id: current_user.id, method: method})
          if InProgressTask.create(user_id: current_user.id, job_id: job_id)
            render js: "TODO: Votre tache: #{job_id} a été ajouté à la liste des taches"
          else
            render js: "TODO: A problem occured while creating the task. Contact the administrator emailing at : "
          end
        else
          render js: "TODO: Too many records"
        end
      else
        render js: "TODO: resource_type incorrect"
      end
    else
      render js: "TODO: Quota exceeded"
    end
  end


  def search

    # retrieve records from provided params

  end

end