class Collector < ActiveRecord::Base
  has_many :collector_versions, dependent: :delete_all

  validates :name, presence: true
  validates :name, uniqueness: true
  # validate :has_versions?

  accepts_nested_attributes_for :collector_versions, allow_destroy: true

  def self.with_name_and_version(name, version)
    includes(:collector_versions).where(name: name, collector_versions: {version: version}).first
  end

  def self.with_id_and_version_id(id, version_id)
    includes(:collector_versions).where(id: id, collector_versions: {id: version_id}).first
  end

  def get_version_id
    collector_versions.first.id
  end

  def has_versions?
    errors[:base] << "A collector must have at least one version." if self.collector_versions.blank?
  end
end
