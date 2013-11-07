class UseCasesController < ApplicationController

  # GET /use_cases
  # GET /use_cases.json
  def index
    @use_cases = UseCase.all
  end

  # TODO : to split and move function in the use_case model
  def get_key
    if collector = ::Collector.find_by(name: params[:collector_name])
      program = Program.find_by(name: params[:program_name])

      use_cases = UseCase.where(user_id: current_user.id, collector_id: collector.id, program_id: program.try(:id))
      
      use_case = 
        use_cases.select do |use_case|
          Set.new(use_case.tags.map(&:name)) == Set.new(params[:tags])
        end.first

      if use_case
        response = use_case.key
      else
        tags = params[:tags].map do |tag_name|
          Tag.find_or_create_by!(name: tag_name)
        end if params[:tags]
        u = UseCase.new(user_id: current_user.id, collector_id: collector.id, program_id: program.try(:id))
        u.tags << tags if tags
        u.key = SecureRandom.hex
        
        if u.save! 
          response = u.key
        else
          response = "Couldn't generate key"
        end 
      end
    else
      response = "Invalid collector name"
    end

    respond_to do |format|
      format.json do
        render json: { response: response }.to_json, status: :ok
      end
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def use_case_params
      params.require(:use_case).permit(:key, :user_id, :collector_id, :collector_version_id, :program_id, :program_version_id)
    end
end
