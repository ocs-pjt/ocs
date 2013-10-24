class PermutationsController < ApplicationController

  def collect
    response = "ok"

    Permutation.transaction do 
      Permutation.create(params[:data]) do |p|
        p.collector_id = 1
        p.user_id = 1
        p.use_case_id = 1
      end
    end

    respond_to do |format|
      format.json do
        render json: { response: response }.to_json, status: :ok
      end
    end
  end

end