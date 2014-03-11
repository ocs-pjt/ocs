class CollectorVersion < ActiveRecord::Base
  include Concerns::File

  default_scope { order('version desc') }
  
  mount_uploader :file, CollectorUploader

  belongs_to :collector

  validates :collector_id, uniqueness: {scope: :version}

  validates :file, presence: true

  validates :version, format: { 
    with: /\A([0-9]|[1-9]\d{0,1})\.([0-9]|[1-9]\d{0,1})\.\d{0,2}\Z/, 
    message: "Wrong version format. Should be something like 0.0.1"
  }
end
