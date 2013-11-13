class Program < ActiveRecord::Base
  has_many :program_versions
  validates :name, presence: true
  validates :name, uniqueness: true

  def self.with_name(name)
    find_by(name: name.try(:strip))
  end

  def self.with_id(id)
    find_by(id: id)
  end
end
