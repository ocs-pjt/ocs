require 'xz'

class ExportsWorker
  include Sidekiq::Worker
  include Sidekiq::Status::Worker

  sidekiq_options retry: false
  #sidekiq_options queue: 'high'

  def perform(options)
    resource_type = options['resource_type']

    # Filter a resource by its search facets and by the resource he collected
    # Because of :first and :last method, this returns an array and not a collection of the resource
    @collection = Search.target_base(resource_type.to_sym).
                    find_by_facets(options['facets']).
                    where('use_cases.user_id' => options['user_id']).
                    __send__(options['method'], Search::MAX_RECORDS)

    filename = "#{Utils.filename(resource_type)}-#{SecureRandom.hex(2)}.csv.xz"

    file_path = '/tmp/' + filename

    file = File.new(file_path, "wb")

    csv = XZ.compress(Search.to_csv(@collection))

    file.write(csv)
    
    Task.create(file: file, user_id: options['user_id'])

    InProgressTask.where(job_id: self.jid).delete_all
    File.delete(file_path)
  end
end