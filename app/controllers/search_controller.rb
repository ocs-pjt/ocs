class SearchController < ApplicationController
  before_action :authenticate_user! # Normal devise authentication

  def export_form
    case params[:resource_type]
    when "trace"
      render partial: 'traces/export_form'
    when "permutation"
      render partial: 'permutations/export_form'
    else 
      render partial: 'regular_expressions/export_form'
    end if request.xhr?
  end

  # Export resources (permutations,traces...) as CSV in background with sidekiq
  def search_export
    # Check if user is over the maximum of tasks he can make
    if InProgressTask.where(user_id: current_user.id).count < Search::QUOTA_TASKS 
      
      # TODO : should check eventually if any params are nil or not formatted correctly
      facets = Search.pre_process(params[:facets])

      if Search.target_keys.include?(resource_type = params[:resource_type].to_sym)
          unless (f = params[:first_records].blank?) && params[:last_records].blank?
            order_method = f ? :last : :first
            if Search.perform(resource_type, facets, current_user.id, order_method, Search::MAX_RECORDS).count > 0
              job_id = ExportsWorker.perform_async({facets: facets, resource_type: resource_type, user_id: current_user.id, order_method: order_method})
              
              InProgressTask.create!(user_id: current_user.id, job_id: job_id)
              flash.now[:success] = "La tâche: <a href='/tasks'>#{job_id}</a> a été ajouté à la liste des tâches.".html_safe
            else
              flash.now[:danger] = "No records to export."
            end
          else
            flash.now[:danger] = "Too many records to export."
          end
      else
        flash.now[:danger] = "The export failed. Reason: resource is incorrect or unknown."
      end
    else
        flash.now[:danger] = "Quota of tasks to be treated has exceeded. Please wait until one finishes."
    end

    render partial: 'shared/message' if request.xhr?
  end


  def search

    # TODO? : retrieve records from provided params

  end

end