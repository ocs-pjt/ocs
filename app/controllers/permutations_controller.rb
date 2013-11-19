class PermutationsController < ApplicationController

  def collect
    if params[:items].presence
      if use_case = UseCase.find_by(key: params[:use_case_key].strip)
        if collector = use_case.collector
          if collector_version = use_case.collector_version
            time = Time.now
            inserts = []
            params['items'].each do |h|
              inserts.push "('#{h['data']}', '#{h['function']}', #{use_case.id}, '#{time}')"
            end
            sql = "INSERT INTO permutations (data, function, use_case_id, created_at) VALUES #{inserts.join(", ")}"
            ActiveRecord::Base.connection.execute sql
          else
            response = "Collector version invalid"
          end
        else
          response = "Collector name invalid"
        end
      else
        response = "Use Case key invalid"
      end
    else
      response = "No data to proceed"
    end

    if response
      render json: { response: response }.to_json, status: :ok
    else
      render nothing: true
    end

  end

end