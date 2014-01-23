class SearchController < ApplicationController

  def search_export
    # process search params and export in background
    facets = params[:facets].delete_if {|key, value| value.blank? } || {}

    if Search::SEARCH_TARGETS.keys.include?(resource_type = params[:resource_type].to_sym)
      
      unless (f = params[:first_records].blank?) && params[:last_records].blank?
        method = f ? :last : :first         
        ExportsWorker.perform_async({facets: facets, resource_type: resource_type, user_id: current_user.id, method: method})
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