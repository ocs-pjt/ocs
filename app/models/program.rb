class Program < ActiveRecord::Base
  has_many :program_versions
  validates :name, presence: true
  validates :name, uniqueness: true

  def self.find_or_create_with_name(name)
    find_by(name: name.try(:strip)) || Program.create(name: name) if name
  end

  def self.with_id(id)
    find_by(id: id)
  end
end
