class CollectorVersion < ActiveRecord::Base
  default_scope { order('created_at desc') }
  
  mount_uploader :file, CollectorUploader

  belongs_to :collector

  validates :collector_id, uniqueness: {scope: :version}

  validates :file, presence: true

  validates :version, format: { 
    with: /\A([0-9]|[1-9]\d{0,1})\.([0-9]|[1-9]\d{0,1})\.\d{0,2}\Z/, 
    message: "Wrong version format. Should be something like 0.0.1"
  }

  def filename
    File.basename(self.file.path)
  end

  def url
    self.file.url
  end

end
