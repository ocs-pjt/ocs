class PermutationsController < ApplicationController

  def collect
    respond_to do |format|
      format.json do
        render json: { response: 'ok' }.to_json, status: :ok
      end
    end
  end

end