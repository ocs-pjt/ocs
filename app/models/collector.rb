class Collector < ActiveRecord::Base
  mount_uploader :file, CollectorUploader

  validates :name, :file, presence: true

  def filename
    File.basename(self.file.path)
  end

  def url
    self.file.url
  end
end
