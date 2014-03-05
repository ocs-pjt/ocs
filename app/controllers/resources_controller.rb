class ResourcesController < ApplicationController
  before_action :authenticate_user! # Normal devise authentication

  def collect 
    case params[:object] && params[:object][:data_type].to_s.downcase
    when 'permutation'
      redirect_to controller: :permutations, action: :collect, params: params
    when 'trace'
      redirect_to controller: :traces, action: :collect, params: params
    when 'regular_expression'
      redirect_to controller: :regular_expressions, action: :collect, params: params
    end
  end

end