class PermutationsWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(params)
    time = Time.now

    inserts = []
    params['items'].each do |h|
      inserts.push "('#{h['data']}', '#{h['function']}', #{params['use_case_id']}, '#{time}')"
    end
    sql = "INSERT INTO permutations (data, function, use_case_id, created_at) VALUES #{inserts.join(", ")}"
    ActiveRecord::Base.connection.execute sql

    # Permutation.transaction do
    #   Permutation.create(params['items']) do |p|
    #     p.use_case_id = use_case.id
    #   end
    # end
  end
end