class UseCasesController < ApplicationController
  before_action :authenticate_user! # Normal devise authentication

  # GET /use_cases
  # GET /use_cases.json
  def index
    @use_cases = UseCase.all
  end

  # WebService to get the use case key from the collector name, its version, the program name and the given tags
  def get_key
    # Check if there is a collector if this name and version
    if collector = ::Collector.with_name_and_version(params[:collector_name], params[:collector_version])
      # Find or create the program
      program_id = Program.find_or_create_by(name: params[:program_name]).id if params[:program_name].presence
      
      tag_names = Tag.tag_names(params[:tags])
      collector_version_id = collector.get_version_id
      
      use_case_params = {
        user_id:              current_user.id, 
        collector_version_id: collector_version_id, 
        program_id:           program_id, 
        tag_names:            tag_names
      }

      if use_case = UseCase.with(use_case_params)
        res = use_case.key
      else
        tags = Tag.find_or_create_tags(tag_names)
        res = UseCase.get_new_key(current_user.id, collector_version_id, program_id, tags)
      end
    else
      res = "Invalid collector name and/or version"
    end

    render json: { response: res }.to_json, status: :ok
  end 

  # Same as get_key but from the website form
  def get_key_from_form
    if collector_version_id = ::CollectorVersion.find_by(id: params[:collector_version_id]).try(:id)
      program_id = Program.try_id(params[:program_id])
      
      tags = Tag.with_ids(params[:tag_ids])
      use_case_params = {
        user_id:              current_user.id, 
        collector_version_id: collector_version_id, 
        program_id:           program_id, 
        tags:                 tags
      }

      if use_case = UseCase.with_params_tags(use_case_params)
        res = use_case.key
      else
        res = UseCase.get_new_key(current_user.id, collector_version_id, program_id, tags)
      end
    else
      res = "Invalid collector and/or version"
    end

    render json: { response: res }.to_json, status: :ok if request.xhr?
  end
  
  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def use_case_params
      params.require(:use_case).permit(:key, :user_id, :collector_version_id, :program_id, :program_version_id)
    end
end
