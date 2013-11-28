class Collector < ActiveRecord::Base
  has_many :collector_versions

  validates :name, presence: true
  validates :name, uniqueness: true

  def self.with_name_and_version(name, version)
    includes(:collector_versions).where(name: name, collector_versions: {version: version}).first
  end

  def self.with_id_and_version_id(id, version_id)
    includes(:collector_versions).where(id: id, collector_versions: {id: version_id}).first
  end


  def get_version_id
    collector_versions.first.id
  end
end
