class Tag < ActiveRecord::Base
  has_and_belongs_to_many :use_cases
  validates :name, presence: true
end
