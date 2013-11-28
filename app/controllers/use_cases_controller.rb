class UseCasesController < ApplicationController

  # GET /use_cases
  # GET /use_cases.json
  def index
    @use_cases = UseCase.all
  end

  def get_key
    if collector = ::Collector.with_name_and_version(params[:collector_name], params[:collector_version])
      program_id = Program.find_or_create_by(name: params[:program_name]).id if params[:program_name].presence
      tag_names = Tag.tag_names_from_str(params[:tags])
      collector_version_id = collector.get_version_id

      use_cases = UseCase.with_params(current_user.id, collector_version_id, program_id)
      
      if use_case = use_cases.select_use_case_with_tag_names(tag_names).first
        response = use_case.key
      else
        tags = Tag.find_or_create_tags(tag_names)
        response = UseCase.get_new_key(current_user.id, collector_version_id, program_id, tags)
      end
    else
      response = "Invalid collector name and/or version"
    end

    render json: { response: response }.to_json, status: :ok
  end 

  def get_key_from_form
    if collector_version_id = ::CollectorVersion.find_by(id: params[:collector_version_id]).try(:id)
      program_id = Program.try_id(params[:program_id])
      
      use_cases = UseCase.with_params(current_user.id, collector_version_id, program_id)
      tags = Tag.with_ids(params[:tag_ids])
      
      if use_case = use_cases.select_use_case_with_tags(tags).first
        response = use_case.key
      else
        response = UseCase.get_new_key(current_user.id, collector_version_id, program_id, tags)
      end
    else
      response = "Invalid collector and/or version"
    end

    render json: { response: response }.to_json, status: :ok if request.xhr?
  end
  
  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def use_case_params
      params.require(:use_case).permit(:key, :user_id, :collector_version_id, :program_id, :program_version_id)
    end
end
