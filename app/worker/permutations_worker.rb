class PermutationsWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(params)
    use_case = UseCase.find(params['use_case_id'])
    Permutation.transaction do
      Permutation.create(params['items']) do |p|
        p.use_case_id = use_case.id
      end
    end
  end
end