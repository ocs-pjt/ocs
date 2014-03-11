class Task < ActiveRecord::Base
  include Concerns::File
  belongs_to :user

  mount_uploader :file, TaskUploader

  def filename
    File.basename(self.file.path)
  end

  def url
    self.file.url
  end

end
