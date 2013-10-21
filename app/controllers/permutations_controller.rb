class PermutationsController < ApplicationController

  def collect
      
    response = "ok"

    unless AuthToken.exists? token: params[:auth_token]
      response = "Invalid authentication token"
    else
      Permutation.transaction do 
        Permutation.create(params[:data]) do |p|
          p.collector_id = 1
          p.user_id = 1
          p.use_case_id = 1
        end
      end
    end

    respond_to do |format|
      format.json do
        render json: { response: response }.to_json, status: :ok
      end
    end
  end

end