class PermutationsController < ApplicationController

  def collect
    response = "ok"


    #DevelopmentProfiler::prof("import") do
    user      = User.find_by(email: params[:email])
    collector = ::Collector.find_by(name: params[:collector_name])
    program   = Program.find_by(name: params[:program_name])
    tags_ids  = params[:tags].split(",").map { |tag| Tag.find_by(name: tag).id }.join(",")

    Permutation.collection.insert(params[:data]) do |p|
      p.user_id       = user.id
      p.collector_id  = collector.id
      p.program_id    = program.id
      p.tags_ids      = tags_ids
    end
    #end
    
    respond_to do |format|
      format.json do
        render json: { response: response }.to_json, status: :ok
      end
    end
  end

end