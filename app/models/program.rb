class Program < ActiveRecord::Base
  has_many :program_versions
  validates :name, presence: true
end
