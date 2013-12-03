class Program < ActiveRecord::Base
  has_many :program_versions, dependent: :delete_all
  
  validates :name, presence: true
  validates :name, uniqueness: true

  def self.try_id(id)
    find_by(id: id).try(:id)
  end
end
