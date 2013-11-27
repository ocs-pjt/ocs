class UseCasesController < ApplicationController

  # GET /use_cases
  # GET /use_cases.json
  def index
    @use_cases = UseCase.all
  end

  def get_key
    if collector = ::Collector.with_name(params[:collector_name])
      program_id = Program.find_or_create_with_name(params[:program_name]).try(:id)
      tag_names = Tag.tag_names_from_str(params[:tags])

      use_cases = UseCase.with_params(current_user.id, collector.id, program_id)
      
      if use_case = use_cases.select_use_case_with_tag_names(tag_names).first
        response = use_case.key
      else
        tags = Tag.find_or_create_tags(tag_names)
        response = save_use_case_with_tags(current_user.id, collector.id, program_id, tags)
      end
    else
      response = "Invalid collector name"
    end

    render json: { response: response }.to_json, status: :ok
  end


  def get_key_from_form
    if collector = ::Collector.with_id(params[:collector_id])
      program_id = Program.with_id(params[:program_id]).try(:id)

      use_cases = UseCase.with_params(current_user.id, collector.id, program_id)
      tags = Tag.with_ids(params[:tag_ids])
      
      if use_case = use_cases.select_use_case_with_tags(tags).first
        response = use_case.key
      else
        response = save_use_case_with_tags(current_user.id, collector.id, program_id, tags)
      end
    else
      response = "Invalid collector name"
    end

    render json: { response: response }.to_json, status: :ok if request.xhr?
  end

  
  private

    def save_use_case_with_tags(user_id, collector_id, program_id, tags)
      uc = UseCase.new_use_case_with_tags(user_id, collector_id, program_id, tags) 
      uc.save! ? uc.key : "Couldn't generate key"
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def use_case_params
      params.require(:use_case).permit(:key, :user_id, :collector_id, :collector_version_id, :program_id, :program_version_id)
    end
end
