class Collector < ActiveRecord::Base
  mount_uploader :file, CollectorUploader

  has_many :collector_versions

  validates :name, :file, presence: true
  validates :name, uniqueness: true

  def filename
    File.basename(self.file.path)
  end

  def url
    self.file.url
  end
end
